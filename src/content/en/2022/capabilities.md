---
#See https://github.com/HTTPArchive/almanac.httparchive.org/wiki/Authors'-Guide#metadata-to-add-at-the-top-of-your-chapters
title: Capabilities
#TODO - Review and update chapter description
description: Capabilities chapter of the 2022 Web Almanac covering brand-new, powerful web platform APIs that give web apps access to hardware interfaces, enhance web-based productivity apps, and more.
authors: [MichaelSolati]
reviewers: [webmaxru, hemanth, beaufortfrancois, tomayac, christianliebel]
analysts: [jrstanley]
editors: []
translators: []
results: https://docs.google.com/spreadsheets/d/13S9FRj8OPRtoMPb94jFh6pPNz3lNS9yztIaorZYe288/
featured_quote: TODO
featured_stat_1: TODO
featured_stat_label_1: TODO
featured_stat_2: TODO
featured_stat_label_2: TODO
featured_stat_3: TODO
featured_stat_label_3: TODO
unedited: true
---

## Introduction

Compelling web experiences aren't limited to basic browser capabilities; they can take advantage of their underlying operating system. Web platform APIs expose these capabilities that are the foundation for Progressive Web Apps (PWA), i.e., web applications capable of providing high-quality experiences found like platform-specific apps. In addition, some functionality on the web platform gives access to lower-level features such as access to the [file system](https://developer.mozilla.org/en-US/docs/Web/API/File_System_Access_API), [geolocation](https://developer.mozilla.org/en-US/docs/Web/API/Geolocation_API), access to the [clipboard](https://developer.mozilla.org/en-US/docs/Web/API/Clipboard_API), and even the ability to detect [gamepads](https://developer.mozilla.org/en-US/docs/Web/API/Gamepad_API).

## Methodology

This chapter used the HTTP Archive's public dataset of millions of pages. These pages were archived as if they were visited on both desktop and mobile, as some sites will serve different content based on what device is requesting the page.

The HTTP Archive's crawler parsed the source code for all of these pages to determine which APIs were used on the pages. For instance, regular expressions, such as `/navigator\.share\s*\(/g`, test pages to see if the API is found in its source code.

This method does have two significant issues. First, it may underreport some APIs used as it can not detect obfuscated code that may exist due to minification. Additionally, it may overreport occurrences of APIs because it does not execute code to see if an API is used. Regardless of these limitations, we believe this methodology should provide a sufficiently good overview of what capabilities are used on the web.

Seventy-five total regular expressions for supported capabilities exist; view this [source file](https://github.com/HTTPArchive/custom-metrics/blob/5d2f74fbdc580e76da5d1dad738fca8381429b9a/dist/fugu-apis.js) to see all the expressions used.

The usage data in this chapter is from a crawl in August 2022; you can view the raw data in the [Capabilities 2022 Results Sheet](https://docs.google.com/spreadsheets/d/13S9FRj8OPRtoMPb94jFh6pPNz3lNS9yztIaorZYe288/edit?usp=sharing).

This chapter will also compare API usage to last year's usage; you can view the raw data from the previous year in the [Capabilities 2021 Results Sheet](https://docs.google.com/spreadsheets/d/1b4moteB9EiLYkH1Ln9qfi1tnU-E4N2UQ87uayWytDKw/edit#gid=2077755325).

## Async Clipboard API

Our first API, the [Async Clipboard API](https://developer.mozilla.org/en-US/docs/Web/API/Clipboard_API), allows read/write access to the system's clipboard.

Note that the Async Clipboard API replaces the deprecated `document.execCommand()` API to access the clipboard.

### Write access

One of the two method families to write data into the clipboard is the [`writeText()`](https://developer.mozilla.org/en-US/docs/Web/API/Clipboard/writeText) and [`write()`](https://developer.mozilla.org/en-US/docs/Web/API/Clipboard/write) methods. `writeText()` takes a String argument and returns a Promise, while `write()` takes an array of [`ClipboardItem`](https://developer.mozilla.org/en-US/docs/Web/API/ClipboardItem)s and also returns a Promise. `ClipboardItem`s take arbitrary data, such as images.

For a list of the mandatory data types that a browser must support by the Clipboards API specification, view this [list by the W3C](https://www.w3.org/TR/clipboard-apis/#mandatory-data-types-x).

```js
await navigator.clipboard.writeText('hello world');

const blob = new Blob(['hello world'], { type: 'text/plain' });
await navigator.clipboard.write([
  new ClipboardItem({
    [blob.type]: blob,
  }),
]);
```

### Read access

The other method family is for reading data from the clipboard. This is done with the [`readText()`](https://developer.mozilla.org/en-US/docs/Web/API/Clipboard/readText) and [`read()`](https://developer.mozilla.org/en-US/docs/Web/API/Clipboard/read) methods. Both methods return a Promise which will resolve with data from the clipboard. `readText()` resolves as a String while `read()` resolves as an array of `ClipboardItem`s.

 ```js
const item = await navigator.clipboard.readText();
const items = await navigator.clipboard.read();
```

To keep user data safe, the `"clipboard-read"` permission of the [Permissions API](https://developer.mozilla.org/en-US/docs/Web/API/Permissions_API) must be granted to read data from the clipboard.

Both read and write access to the clipboard is available on modern versions of Chrome, Edge, and Safari. Firefox only supports `writeText()`.

### Growth

The Async Clipboard API saw growth in usage from 8.91% in 2021 to 10.10% in 2022 on desktop. On mobile, there was also growth from 8.25% in 2021 to 9.27% in 2022. As a result, this year, the Async Clipboard API was the most used API on both desktop and mobile, beating the Web Share API (last year's most used API).

## Web Share API

The [Web Share API](https://developer.mozilla.org/en-US/docs/Web/API/Web_Share_API) invokes the platform-specific sharing mechanism of the device, allowing data such as text, a URL, or files from a web application to be shared with any other application, such as mail clients, messaging applications, and more.

The method called to share data is [`navigator.share()`](https://developer.mozilla.org/en-US/docs/Web/API/Navigator/share). `navigator.share()` accepts an object containing the data to share and returns a Promise. Not every file type can be shared, though, and the [`navigator.canShare()`](https://developer.mozilla.org/en-US/docs/Web/API/Navigator/canShare) method can test a data object to see if the browser can share it.

After calling `navigator.share()`, the browser will open a built-in sheet where users select which application to share the data with.

Additionally, the Web Share API can only be triggered by a user's interaction with the page, such as a button click; the Web Share API can not be called arbitrarily by executed code.

```js
const data = {
  url: 'https://almanac.httparchive.org/en/2022/capabilities',
};

if (navigator.canShare(data)) {
  await navigator.share(data);
}
```

The Web Share API is available on modern versions of Chrome, Edge, and Safari. For Chrome, though, it is only supported on Windows and Chrome OS.

### Growth

The Web Share API shrunk in usage from 9% in 2021 to 8.84% in 2022 on desktop. On mobile, usage shrunk from 8.58% in 2021 to 8.36% in 2022. As a result, this year, the Web Share API was the second most used API on both desktop and mobile, falling behind the Async Clipboard API (last year's second most used API).

## Add to Home Screen

The ability to add a web application to a device's home screen is a feature we didn't look at in last year's Capabilities report. To calculate how many sites have this functionality, pages were tested to see if they had a listener for the [`beforeinstallprompt`](https://developer.mozilla.org/en-US/docs/Web/API/Window/beforeinstallprompt_event) event.

The `beforeinstallprompt` event triggers right before a user is about to be prompted to "install" a web app. The usage of an event listener for the `beforeinstallprompt` event is not required for web apps to be added to a device's home screen, so it is safe to assume that the actual usage is much higher. However, this methodology will allow us to get an idea of how popular of a feature it is.

The ability to add an application to the home screen is a crucial feature of PWAs. To use this feature, web applications must meet the following criteria:

- The web app can not already be installed.
- The user must have spent at least 30 seconds viewing the page.
- The user must have clicked or tapped at least once on the page.
- The web app must be served over HTTPS.
- The web app must include a [web app manifest](https://developer.mozilla.org/en-US/docs/Web/Manifest).
- The web app must register a service worker with a `fetch` handler.

Once an application is added, or installed, users can use it as if it was an installed app. Installed applications can appear in Start menus, desktops, home screens, the Applications folder, a device search, content sharing sheets, and more.

The ability to add to the home screen is only available on modern versions of Chrome and Edge.

### Usage

As mentioned, the add to home screen capability was not measured last year. However, for posterity and detailed reporting, the `beforeinstallprompt` event was used on 8.56% of desktop pages and 7.71% of mobile pages, making it the third most used capability on desktop and mobile.
