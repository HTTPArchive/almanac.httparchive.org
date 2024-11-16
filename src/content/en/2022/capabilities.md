---
#See https://github.com/HTTPArchive/almanac.httparchive.org/wiki/Authors'-Guide#metadata-to-add-at-the-top-of-your-chapters
title: Capabilities
description: Capabilities chapter of the 2022 Web Almanac covering brand-new, powerful web platform APIs that give web apps access to hardware interfaces, enhance web-based productivity apps, and more.
hero_alt: Hero image of Web Almanac charactes with superhero capes plugging various capabilities into a web page.
authors: [MichaelSolati]
reviewers: [tomayac, christianliebel]
analysts: [tunetheweb]
editors: [tunetheweb]
translators: []
MichaelSolati_bio: Michael is a Developer Advocate at Amplication, focusing on helping developers build APIs and drink IPAs. Additionally, he is a Web GDE and has found his love in creating compelling experiences on the web and the voodoo ways of the web...
results: https://docs.google.com/spreadsheets/d/13S9FRj8OPRtoMPb94jFh6pPNz3lNS9yztIaorZYe288/
featured_quote: The Capabilities Project allows applications to migrate to the web, removing some barriers associated with platform-specific applications.
featured_stat_1: 38
featured_stat_label_1: Capabilities were used on one site.
featured_stat_2: ~10%
featured_stat_label_2: Sites on mobile and desktop use the _Async Clipboard API_.
featured_stat_3: 8%
featured_stat_label_3: Sites on mobile and desktop use the _Web Share API_.
---

## Introduction

Compelling web experiences aren't limited to basic browser capabilities; they can take advantage of their underlying operating system. Web platform APIs expose these capabilities that are the foundation for [Progressive Web Apps (PWA)](./pwa)—web applications capable of providing high-quality experiences like platform-specific apps.

In addition, some functionality on the web platform gives access to lower-level features such as access to the [file system](https://developer.mozilla.org/docs/Web/API/File_System_Access_API), [geolocation](https://developer.mozilla.org/docs/Web/API/Geolocation_API), access to the [clipboard](https://developer.mozilla.org/docs/Web/API/Clipboard_API), and even the ability to detect [gamepads](https://developer.mozilla.org/docs/Web/API/Gamepad_API).

## Methodology

This chapter used the HTTP Archive's public dataset of millions of pages. These pages were archived as if they were visited on both desktop and mobile, as some sites will serve different content based on what device is requesting the page.

The HTTP Archive's crawler then parsed the source code for all of these pages to determine which APIs were (potentially) used on the pages. For instance, regular expressions, such as `/navigator\.share\s*\(/g`, test pages to see if in the concrete case the [Web Share API](https://developer.mozilla.org/docs/Web/API/Web_Share_API) is found in its source code.

This method does have two significant issues. First, it may underreport some APIs used as it can not detect obfuscated code that may exist due to minification, for example, when `navigator` was minified to `n`. Additionally, it may overreport occurrences of APIs because it does not execute code to see if an API is actually used. Regardless of these limitations, we believe this methodology should provide a sufficiently good overview of what capabilities are used on the web.

Seventy-five total regular expressions for supported capabilities exist; view this <a hreflang="en" href="https://github.com/HTTPArchive/custom-metrics/blob/5d2f74fbdc580e76da5d1dad738fca8381429b9a/dist/fugu-apis.js">source file</a> to see all the expressions used.

The usage data in this chapter is from a crawl in June 2022; you can view the raw data in the <a hreflang="en" href="https://docs.google.com/spreadsheets/d/13S9FRj8OPRtoMPb94jFh6pPNz3lNS9yztIaorZYe288/edit?usp=sharing">Capabilities 2022 Results Sheet</a>.

This chapter will also compare API usage to last year's usage; you can view the raw data from the previous year in the <a hreflang="en" href="https://docs.google.com/spreadsheets/d/1b4moteB9EiLYkH1Ln9qfi1tnU-E4N2UQ87uayWytDKw/edit#gid=2077755325">Capabilities 2021 Results Sheet</a>.

## Async Clipboard API

Our first API, the [_Async Clipboard API_](https://developer.mozilla.org/docs/Web/API/Clipboard_API), allows read/write access to the system's clipboard.

Note that the Async Clipboard API replaces the deprecated `document.execCommand()` API to access the clipboard.

### Write access

In order to write data into the clipboard, there are the [`writeText()`](https://developer.mozilla.org/docs/Web/API/Clipboard/writeText) and [`write()`](https://developer.mozilla.org/docs/Web/API/Clipboard/write) methods. The `writeText()` method takes a String argument and returns a Promise, while `write()` takes an array of [`ClipboardItem`](https://developer.mozilla.org/docs/Web/API/ClipboardItem) objects and also returns a Promise. `ClipboardItem` objects can hold arbitrary data, such as images.

A list of the mandatory data types a browser must support by the Clipboards API specification exists; see this <a hreflang="en" href="https://www.w3.org/TR/clipboard-apis/#mandatory-data-types-x">list by the W3C</a>. Unfortunately, not all vendors support the complete list; check browser-specific documentation when possible.

```js
await navigator.clipboard.writeText("hello world");

const blob = new Blob(["hello world"], { type: "text/plain" });
await navigator.clipboard.write([
  new ClipboardItem({
    [blob.type]: blob,
  }),
]);
```

### Read access

In order to read data from the clipboard, there are the [`readText()`](https://developer.mozilla.org/docs/Web/API/Clipboard/readText) and [`read()`](https://developer.mozilla.org/docs/Web/API/Clipboard/read) methods. Both methods return a Promise which will resolve with data from the clipboard. The `readText()` method resolves as a String while `read()` resolves as an array of `ClipboardItem` objects.

```js
const item = await navigator.clipboard.readText();
const items = await navigator.clipboard.read();
```

To keep user data safe, the `"clipboard-read"` permission of the [Permissions API](https://developer.mozilla.org/docs/Web/API/Permissions_API) must be granted to read data from the clipboard.

Both read and write access to the clipboard is available on modern versions of Chrome, Edge, and Safari. Firefox only supports `writeText()`.

### Growth of the Async Clipboard API

{{ figure_markup(
  image="Async-Clipboard-API-Usage.png",
  caption="Usage of the Async Clipboard API from 2021 to 2022 on desktop and mobile.",
  description="The Async Clipboard API grew in usage from 8.91% in 2021 to 10.10% in 2022 on desktop. On mobile, usage grew from 8.25% in 2021 to 9.27% in 2022.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vTZp0g2lyspAvJUN-xV4TtqC_9wrRMqyg_bEzHCd1Be3p0Yhy3o2k-SH7DGX5a-LfaodNUTl4Ai-NXg/pubchart?oid=602028150&format=interactive",
  sheets_gid="637848098",
  sql_file="fugu.sql"
) }}

The Async Clipboard API saw growth in usage from 8.91% in 2021 to 10.10% in 2022 on desktop. On mobile, there was also growth from 8.25% in 2021 to 9.27% in 2022. As a result, this year, the Async Clipboard API was the most used API on both desktop and mobile, beating the Web Share API (last year's most used API).

## Web Share API

The [_Web Share API_](https://developer.mozilla.org/docs/Web/API/Web_Share_API) invokes the platform-specific sharing mechanism of the device, allowing data such as text, a URL, or files from a web application to be shared with any other application, such as mail clients, messaging applications, and more.

The method called to share data is [`navigator.share()`](https://developer.mozilla.org/docs/Web/API/Navigator/share). The `navigator.share()` method accepts an object containing the data to share and returns a Promise. Not every file type can be shared, though, and the [`navigator.canShare()`](https://developer.mozilla.org/docs/Web/API/Navigator/canShare) method can test a data object to see if the browser can share it. You can see the [list of shareable file types](https://developer.mozilla.org/docs/Web/API/Navigator/share#shareable_file_types) on MDN.

After calling `navigator.share()`, the browser will open a platform-specific sheet where users select which application to share the data with.

Additionally, the Web Share API can only be triggered by a user's interaction with the page, such as a button click; the Web Share API cannot be called arbitrarily by executed code.

```js
const data = {
  url: "https://almanac.httparchive.org/en/2022/capabilities",
};

if (navigator.canShare(data)) {
  try {
    await navigator.share(data);
  catch (err) {
    console.error(err.name, err.message);
  }
}
```

The Web Share API is available on modern versions of Chrome, Edge, and Safari. For Chrome, though, it is only supported on Windows and ChromeOS.

### Growth of the Web Share API

{{ figure_markup(
  image="Web-Share-API-Usage.png",
  caption="Usage of the Web Share API from 2021 to 2022 on desktop and mobile.",
  description="The Web Share API shrunk in usage from 9.00% in 2021 to 8.84% in 2022 on desktop. On mobile, usage shrunk from 8.58% in 2021 to 8.36% in 2022.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vTZp0g2lyspAvJUN-xV4TtqC_9wrRMqyg_bEzHCd1Be3p0Yhy3o2k-SH7DGX5a-LfaodNUTl4Ai-NXg/pubchart?oid=934956615&format=interactive",
  sheets_gid="1887140434",
  sql_file="fugu.sql"
) }}

The Web Share API shrunk in usage from 9.00% in 2021 to 8.84% in 2022 on desktop. On mobile, usage shrunk from 8.58% in 2021 to 8.36% in 2022. As a result, this year, the Web Share API was the second most used API on both desktop and mobile, falling behind the Async Clipboard API—last year's second most used API.

On many sites, you can find the Web Share API in use. For example, social media platforms, documentation sites, and others use it as a great way to share content. Some examples where you can find the API in use include <a hreflang="en" href="https://web.dev/">web.dev</a> and [twitter.com](https://x.com/).

{{ figure_markup(
  gif="Web-Share-API.gif",
  image="Web-Share-API.webp",
  caption="Sharing a Twitter profile using the Web Share API.",
  description="Sharing a Twitter profile using the Web Share API.",
  width=640,
  height=360
) }}

## Add to Home Screen

The ability to add a web application to a device's home screen is a feature we didn't look at in last year's Capabilities report. To calculate how many sites have this functionality, pages were tested to see if they had a listener for the [`beforeinstallprompt`](https://developer.mozilla.org/docs/Web/API/Window/beforeinstallprompt_event) event.

Note that the `beforeinstallprompt` event is a Chromium-only API and is currently <a hreflang="en" href="https://wicg.github.io/manifest-incubations/index.html#installation-prompts">incubating within the WICG</a>.

The `beforeinstallprompt` event triggers right before a user is about to be prompted to "install" a web app. The usage of an event listener for the `beforeinstallprompt` event is not required for web apps to be added to a device's home screen, so it is safe to assume that the actual usage is much higher. However, this methodology will allow us to get an idea of how popular of a feature it is.

The ability to add an application to the home screen is a crucial feature of PWAs. To use this feature, web applications must meet the <a hreflang="en" href="https://web.dev/install-criteria/#criteria">following criteria</a>:

- The web app must not already be installed.
- The user must have spent at least 30 seconds viewing the page at any time.
- The user must have clicked or tapped at least once on the page at any time.
- The web app must be served over HTTPS.
- The web app must include a [web app manifest](https://developer.mozilla.org/docs/Web/Manifest) with:
  - `short_name` or `name`.
  - `icons` (must include a 192×192px and a 512×512px icon).
  - `start_url`.
  - `display` (must be one of `fullscreen`, `standalone`, or `minimal-ui`).
  - `prefer_related_applications` (must not be present, or `be false`).
- The web app must register a service worker with a `fetch` handler.

Installed applications can appear in Start menus, desktops, home screens, the Applications folder, when searching for applications on a device, content sharing sheets, and more.

The ability to add to the home screen is only available on modern versions of Chrome, Edge, and Safari on iOS and iPadOS.

### Usage of Add to Home Screen

{{ figure_markup(
  caption="Usage of Add to Home Screen on mobile.",
  content="7.71%",
  classes="big-number",
  sheets_gid="1887140434",
  sql_file="fugu.sql"
)
}}

As mentioned, the add to home screen capability was not measured last year. However, for posterity and detailed reporting, the `beforeinstallprompt` event was used on 8.56% of desktop pages and 7.71% of mobile pages, making it the third most used capability on desktop and mobile.

By taking advantage of the `beforeinstallprompt` event, developers can provide a customized experience in how users install their web application. One example is YouTube TV, which invites users to install their application to access it more quickly and easily.

{{ figure_markup(
  gif="Add-to-Home-Screen.gif",
  image="Add-to-Home-Screen.webp",
  caption="Installing YouTube TV from an in app prompt, powered by the `beforeinstallprompt` event.",
  description="Installing YouTube TV from an in app prompt, powered by the `beforeinstallprompt` event.",
  width=640,
  height=360
) }}

## Media Session API

The [_Media Session API_](https://developer.mozilla.org/docs/Web/API/Media_Session_API) allows developers to create custom media notifications for audio or video content on the web. The API includes action handlers that browsers can use to access media control on keyboards, headsets, and the software controls on a device's notification area and lock screens. The Media Session API empowers users to know and control what's playing on a web page without needing to be actively viewing said page.

When a page plays audio or video content, users get a media notification that appears in their mobile device's notification tray or on their desktop's media hub. Browsers will try to show a title and an icon, but the Media Session API allows the notification to be customized with rich media metadata, such as the title, artist name, album name, and album artwork.

```js
navigator.mediaSession.metadata = new MediaMetadata({
  title: "Creep",
  artist: "Radiohead",
  album: "Pablo Honey",
  artwork: [
    {
      src: "https://via.placeholder.com/96",
      sizes: "96x96",
      type: "image/png",
    },
    {
      src: "https://via.placeholder.com/128",
      sizes: "128x128",
      type: "image/png",
    },
    {
      src: "https://via.placeholder.com/192",
      sizes: "192x192",
      type: "image/png",
    },
    {
      src: "https://via.placeholder.com/256",
      sizes: "256x256",
      type: "image/png",
    },
    {
      src: "https://via.placeholder.com/384",
      sizes: "384x384",
      type: "image/png",
    },
    {
      src: "https://via.placeholder.com/512",
      sizes: "512x512",
      type: "image/png",
    },
  ],
});
```

The Media Session API is available on modern versions of Chrome, Edge, Firefox, and Safari.

### Usage of the Media Session API

{{ figure_markup(
  caption="Usage of Media Session API on mobile.",
  content="7.41%",
  classes="big-number",
  sheets_gid="1887140434",
  sql_file="fugu.sql"
)
}}

The Media Session API was not measured last year. In its first year of tracking, the API was used on 8.37% of desktop pages and 7.41% of mobile pages, making it the fourth most used capability on desktop and mobile.

Web applications such as YouTube, YouTube Music, Spotify, and others take advantage of the Media Session API and provide rich controls for the video or audio played.

{{ figure_markup(
  image="Media-Session-API.png",
  caption="Accessing controls and information for YouTube Music via the Window's Taskbar.",
  description="Accessing controls and information for YouTube Music via the Window's Taskbar.",
) }}

For a deeper dive into video usage on the web, check out the [Media](./media#video) chapter.

## Device Memory API

A device's capabilities depend on a few things, like the network, the CPU core count, and the amount of memory available. The [_Device Memory API_](https://developer.mozilla.org/docs/Web/API/Device_Memory_API) provides insight into the memory available by providing the read-only property `deviceMemory` on the `Navigator` interface. The property returns an approximate amount of device memory in gigabytes as a floating point number.

The value returned is imprecise, protecting the user's privacy. It's calculated by rounding down to the nearest power of 2, then dividing that number by 1,024. The number is also clamped within an upper and lower bound. So you can expect the numbers: `0.25`, `0.5`, `1`, `2`, `4`, and `8` (gigabytes).

```js
const memory = navigator.deviceMemory;
console.log('This device has at least ', memory, 'GiB of RAM.');
```

The Device Memory API is only available on modern versions of Chrome and Edge.

### Usage of the Device Memory API

{{ figure_markup(
  caption="Usage of Device Memory API on mobile.",
  content="5.76%",
  classes="big-number",
  sheets_gid="1887140434",
  sql_file="fugu.sql"
)
}}

The Device Memory API was not measured last year. In its first year of tracking, the API was used on 6.27% of desktop pages and 5.76% of mobile pages, making it the fifth most used capability on desktop and mobile.

For the release of Facebook's 2019 redesign, FB5, they actively integrated adaptive loading into this new version. They did this by adapting based on users' actual hardware, changing what loaded and what ran based on what users were using. For example, on the desktop, Facebook defined buckets of users based on CPU cores ([`navigator.hardwareConcurrency`](https://developer.mozilla.org/docs/Web/API/Navigator/hardwareConcurrency)) and device memory (`navigator.deviceMemory`) available.

Check out <a hreflang="en" href="https://www.youtube.com/watch?v=puUPpVrIRkc&t=1443s">this video</a> from Chrome Dev Summit 2019, starting at 24:03, where Nate Schloss shares how Facebook handles adaptive loading using features such as the Device Memory API.

## Service Worker API

[_Service workers_](https://developer.mozilla.org/docs/Web/API/Service_Worker_API) are one of the core components of Progressive Web Apps. They act as a client-side proxy that puts developers in control of the system's cache and how to respond to resource requests. By pre-caching essential resources, developers can eliminate the dependence on the network, ensuring instant and reliable experiences.

In addition to caching resources, service workers can update assets from the server, allow for push notifications, and allow access to the background and periodic background sync APIs.

While service workers have become widely adopted and supported by major browsers, not all features of service workers are available on all browsers. An example of a currently unsupported feature is that of the Push API on Safari. Safari will support the Push API in the upcoming release of <a hreflang="en" href="https://www.apple.com/macos/macos-ventura-preview/features/">macOS Ventura</a> in 2022 and <a hreflang="en" href="https://www.apple.com/ios/ios-16/features/">iOS 16</a> and iPadOS 16 in 2023.

The Service Worker API is available on modern versions of Chrome, Edge, Firefox, and Safari.

### Growth of the Service Worker API

{{ figure_markup(
  image="Service-Worker-API-Usage.png",
  caption="Usage of the Service Worker API from 2021 to 2022 on desktop and mobile.",
  description="The Service Worker API grew in usage from 3.05% in 2021 to 4.17% in 2022 on desktop. On mobile, usage grew from 3.22% in 2021 to 3.85% in 2022.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vTZp0g2lyspAvJUN-xV4TtqC_9wrRMqyg_bEzHCd1Be3p0Yhy3o2k-SH7DGX5a-LfaodNUTl4Ai-NXg/pubchart?oid=304563360&format=interactive",
  sheets_gid="208641216",
  sql_file="fugu.sql"
) }}

The Service Worker API was not measured in last year's Capabilities chapter. However, using [data from the previous year's PWA chapter](/en/2021/pwa#service-workers-usage), the API grew in usage from 3.05% to 4.17% on desktop and 3.22% to 3.85% on mobile pages, making it the sixth most used capability on desktop and the seventh most used mobile.

Note that how the service worker usage in the PWA chapter is measured differs from how the Capabilities chapter measures it. Additionally, a bug in the data pipeline for last year's PWA chapter was found, resulting in an undercounting of service worker usage.

For a deeper dive into service worker usage on the web, check out the [PWA chapter](/en/2022/pwa#service-workers) of the 2022 Web Almanac.

## Gamepad API

The [_Gamepad API_](https://developer.mozilla.org/docs/Web/API/Gamepad_API) is how web applications respond to input from gamepads and other game controllers. This API has three interfaces; one that represents the controller connected to the device, one that represents buttons on the connected controller, and finally, one that is for events fired when a gamepad is connected or disconnected.

```js
window.addEventListener("gamepadconnected", (e) => {
  const gp = navigator.getGamepads()[e.gamepad.index];
  console.log(`Controller connected at index ${gp.index}`);
});
```

The Gamepad API is available on modern versions of Chrome, Edge, Firefox, and Safari.

### Growth of the Gamepad API

{{ figure_markup(
  image="Gamepad-API-Usage.png",
  caption="Usage of the Gamepad API from 2021 to 2022 on desktop and mobile.",
  description="The Gamepad API shrunk in usage from 4.39% in 2021 to 4.12% in 2022 on desktop. On mobile, usage shrunk from 5.10% in 2021 to 4.65% in 2022.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vTZp0g2lyspAvJUN-xV4TtqC_9wrRMqyg_bEzHCd1Be3p0Yhy3o2k-SH7DGX5a-LfaodNUTl4Ai-NXg/pubchart?oid=679096832&format=interactive",
  sheets_gid="1737472884",
  sql_file="fugu.sql"
) }}

The Gamepad API shrunk in usage from 4.39% in 2021 to 4.12% in 2022 on desktop. On mobile, use shrunk from 5.10% in 2021 to 4.65% in 2022. As a result, this year, the Gamepad API was the seventh most used capability on desktop and the sixth most used mobile.

Web applications such as Google's Stadia, NVIDIA's GeForce Now, and Microsoft's Xbox Cloud Gaming provide gaming experiences that run on the cloud comparable to the experience of running games on local devices or a gaming console. Thanks to the Gamepad API, these web applications allow users to use traditional console game controllers rather than just a keyboard and mouse.

{{ figure_markup(
  image="Gamepad-API.webp",
  gif="Gamepad-API.gif",
  caption="Connecting an Xbox controller to Google Stadia in the Chrome browser.",
  description="Connecting an Xbox controller to Google Stadia in the Chrome browser.",
  width=640,
  height=360
) }}

## Push API

The [_Push API_](https://developer.mozilla.org/docs/Web/API/Push_API) allows web applications to receive messages from a server regardless of whether the application was in the foreground. Developers can send asynchronous notifications and updates to users who opt in, giving them meaningful updates and a nudge to reengage with an application.

Web applications must also have a service worker to receive push notifications from a server. From within the service worker, push notifications can be subscribed to using the [`PushManager.subscribe()`](https://developer.mozilla.org/docs/Web/API/PushManager/subscribe) method.

The Push API is available on modern versions of Chrome, Edge, and Firefox.

### Usage of the Push API

{{ figure_markup(
  caption="Usage of Push API on mobile.",
  content="1.86%",
  classes="big-number",
  sheets_gid="1887140434",
  sql_file="fugu.sql"
)
}}

The Push API was not measured last year. In its first year of tracking, the API was used on 2.03% of desktop pages and 1.86% of mobile pages, making it the eighth most used capability on desktop and mobile.

## Project Fugu

Many features users expect to belong to platform-specific applications also exist on the web. However, thanks to the Capabilities Project, known by many as Project Fugu, these features exist on the web. Project Fugu is a cross-company effort to bring feature parity to web applications, considering what iOS, Android, or desktop apps can do. Project Fugu works on exposing platform-specific capabilities to the web while maintaining user security, privacy, trust, and the web's other core tenets.

Project Fugu comprises Microsoft, Intel, Samsung, Google, and many other groups and individuals.

Check out <a hreflang="en" href="https://developer.chrome.com/blog/fugu-status">this post</a> on the Chrome Developers blog to learn more about the Capabilities Project.

## Conclusion

Capabilities unlock new possibilities and functionality for developers to take advantage of on the web. This chapter shared eight of the most popular web platform APIs currently being used on the web. It also showcased some of these capabilities used in different web applications. The beauty of the web is that it can use these platform-based functionalities without needing to (necessarily) be installed onto a device or additional libraries and plugins.

Some exciting experiences that utilize the web's capabilities include <a hreflang="en" href="https://whatwebcando.today/">What Web Can Do Today?</a> (WWCDT) and <a hreflang="en" href="https://www.discourse.org/">Discourse</a>. WWCDT, which uses 38 of the capabilities we track, showcases many Web APIs with a live demo of each API. Discourse provides communities with web forums and uses 14 of the capabilities we track, such as the Badging API, so users can see the number of unread notifications they have.

The Capabilities Project, Project Fugu, allows applications to migrate to the web, removing some barriers associated with platform-specific applications. No need to write "native" code, no need to worry about users having access to the latest updates, and no need to get users to search for and download from your application in app stores. The web, and its capabilities, open up all new possibilities in building compelling experiences for users.
