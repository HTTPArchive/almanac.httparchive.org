---
#See https://github.com/HTTPArchive/almanac.httparchive.org/wiki/Authors'-Guide#metadata-to-add-at-the-top-of-your-chapters
title: Capabilities
description: Capabilities chapter of the 2021 Web Almanac covering brand-new, powerful web platform APIs that give web apps access to hardware interfaces, enhance web-based productivity apps, and more.
authors: [christianliebel]
reviewers: [tomayac, hemanth]
analysts: [tomayac]
editors: [tunetheweb]
translators: []
results: https://docs.google.com/spreadsheets/d/1b4moteB9EiLYkH1Ln9qfi1tnU-E4N2UQ87uayWytDKw/
christianliebel_bio: Christian Liebel is a consultant at <a hreflang="en" href="https://thinktecture.com">Thinktecture</a>, supporting clients from various business areas in implementing great web applications. He is a Microsoft MVP for Developer Technologies, Google GDE for Web/Capabilities and Angular, and participates in the W3C Web Applications Working Group.
featured_quote: Capabilities are new web platform APIs that unlock entirely new use cases for web applications.
featured_stat_1: 9%
featured_stat_label_1: Desktop web sites using the _Web Share API_
featured_stat_2: 8.25%
featured_stat_label_2: Mobile sites using the _Async Clipboard API_
featured_stat_3: 11
featured_stat_label_3: Mobile sites using _Declarative Link Capturing_
---

## Introduction
Capabilities are new web platform APIs that unlock entirely new use cases for web applications. Those new APIs are essential for [Progressive Web Apps (PWA)](./pwa), a web-based application model. A PWA is a web app that users can install to their system. PWAs run even offline and launch quickly. To integrate with the underlying operating system, PWAs can only use web platform APIs. While browsers have already exposed some lower-level features to the web (e.g., [geolocation](https://developer.mozilla.org/en-US/docs/Web/API/Geolocation_API), [gamepad](https://developer.mozilla.org/en-US/docs/Web/API/Gamepad_API), or [webcam](https://developer.mozilla.org/en-US/docs/Web/API/MediaDevices/getUserMedia) access), many APIs were still missing or were clumsy to use (e.g., file system or clipboard access).

### Project Fugu

The <a hreflang="en" href="https://www.chromium.org/teams/web-capabilities-fugu">Capabilities Project</a> (codename Fugu) is a joint effort by Microsoft, Intel, Google, and other Chromium contributors. It tries to bridge the gap between platform-specific applications and web apps by designing and implementing new powerful web platform APIs in a secure and privacy-preserving manner (see also the [Privacy](./privacy) chapter). As capabilities unlock more and more use cases, they lay the path for entire new application categories to finally make the shift to the web (e.g., IDEs, image editors, or office applications).

<figure>
<blockquote>_Project Fugu_ is an effort to close gaps in the web's capabilities enabling new classes of applications to run on the web… APIs that Project Fugu is delivering enable new experiences on the web while preserving the web's core benefits of security, low-friction, and cross-platform delivery. All Project Fugu API proposals are made in the open and on the standards track.</blockquote>
<figcaption>— <cite><a hreflang="en" href="https://www.chromium.org/teams/web-capabilities-fugu">Web Capabilities Team</a></cite></figcaption>
</figure>

Over the last two years, the focus for the Fugu team has been on capabilities for desktop productivity applications and hardware-related APIs. This chapter briefly introduces several new capabilities and analyzes how many different desktop and mobile websites use them. As capabilities are particularly interesting for app-like websites, their relative usage is comparatively low. This is why absolute website numbers are used in this chapter. For each capability, there will be a demo website or app that makes use of it.

### Methodology

This chapter uses the HTTP Archive data set. For security reasons, some APIs require a user gesture (i.e., a click or keypress) to function. As the HTTP Archive crawler does not support detecting those APIs during runtime, the source code of the websites is parsed statically instead: For instance, the regular expression `/navigator\.share\s*\(/g` is matched against the website's source code to determine if it (potentially) makes use of the _Web Share API_.

This method is not perfectly accurate, as it doesn't measure the actual use of an API, and developers may invoke an API using a different syntax or work with minified code. However, this approach should provide a sufficiently good overview. You can find the exact regular expressions for the 30 supported capabilities in this <a hreflang="en" href="https://github.com/HTTPArchive/legacy.httparchive.org/blob/master/custom_metrics/fugu-apis.js">source file</a>.

All usage data in this chapter is based on the July 2021 crawl. You can find the raw data in the <a hreflang="en" href="https://docs.google.com/spreadsheets/d/1b4moteB9EiLYkH1Ln9qfi1tnU-E4N2UQ87uayWytDKw/">Capabilities 2021 Results Sheet</a>.

For the two more commonly used APIs in this chapter, additional data from Chrome Platform Status is presented. This data shows how the API usage has changed over the last 12 months prior to the publication of this chapter.

### Status of the presented APIs

Please note that most of the APIs presented here are so-called _incubations_. Unless noted, they are not (yet) W3C Recommendations, i.e., official web standards. Instead, these APIs are being worked on in the Web Platform Incubator Community Group (WICG), where browser vendors and developers can discuss new features.

Some APIs have already shipped in several browsers; others are only available on Chromium-based ones. These browsers include Google Chrome, Microsoft Edge, Opera, Brave, or Samsung Internet. Please note that vendors of Chromium-based browsers can choose to disable specific capabilities, so not all APIs may be available in all browsers based on Chromium. Some capabilities may also only be available after activating a flag in the browser settings.

## Async Clipboard API
The [_Async Clipboard API_](https://developer.mozilla.org/en-US/docs/Web/API/Clipboard_API) allows you to read and write data from or to the clipboard. Due to its asynchronous nature, it enables use cases like scaling down an image while pasting it—all without blocking the UI. It replaces less capable APIs like `document.execCommand()` that were previously used to interact with the clipboard.

### Write access
The Async Clipboard API offers two methods to copy data to the clipboard: The shorthand method [`writeText()`](https://developer.mozilla.org/en-US/docs/Web/API/Clipboard/writeText) takes plain text as an argument which the browser then copies to the clipboard. The [`write()`](https://developer.mozilla.org/en-US/docs/Web/API/Clipboard/write) method takes an array of clipboard items that could contain arbitrary data. Browsers can decide to only implement certain data formats. The Clipboard API specification specifies a <a hreflang="en" href="https://www.w3.org/TR/clipboard-apis/#mandatory-data-types-x">list of mandatory data types</a> browsers must support as a minimum, including plain text, HTML, URI lists, and PNG images.

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
Similar to copying data to the clipboard, there are two methods to paste data back from the clipboard: First, another shorthand method called [`readText()`](https://developer.mozilla.org/en-US/docs/Web/API/Clipboard/readText) that returns plain text from the clipboard. Using the [`read()`](https://developer.mozilla.org/en-US/docs/Web/API/Clipboard/read) method, you access all items in the clipboard in the data formats supported by the browser.

```js
const item = await navigator.clipboard.readText();
const items = await navigator.clipboard.read();
```

The browser may show a permission prompt or a different UI for privacy reasons before granting the website access to the clipboard contents. The Async Clipboard API is available in Chrome, Edge, and Safari (<a hreflang="en" href="https://caniuse.com/async-clipboard">current browser support for the Async Clipboard API</a>). Firefox only supports the `writeText()` method.

{{ figure_markup(
caption="Desktop websites using the Async Clipboard API.",
content="560,359",
classes="big-number",
sheets_gid="2077755325",
sql_file="fugu.sql"
)
}}

With 560,359 (8.91%) desktop and 618,062 (8.25%) mobile sites, the Async Clipboard API (`writeText()` method) is one of the most used Fugu APIs. The `write()` method is used on 1,180 desktop and 1,227 mobile sites. As an example, the commercial website <a hreflang="en" href="https://clippingmagic.com/">Clipping Magic</a> allows you to remove the background of an image with the help of an AI algorithm. Just paste an image from the clipboard, and the website will remove its background.

The high usage of this API is probably related to a script that is included with embedded YouTube videos. The `writeText()` method is called when the user clicks the "copy link" button in the video player.

{{ figure_markup(
image="async-clipboard-api.jpg",
caption='Clipping Magic uses artificial intelligence to remove the background of images pasted via the Async Clipboard API.',
description='Screenshot of the Clipping Magic application with an image on the left, and the same image without a background on the right',
width=699,
height=440
) }}

In recent months, the use of the API has increased sharply at a low level. While the `read()` method was active on only 0.00032 percent of all page loads in November 2020, usage increased exponentially to 0.002921 percent by October 2021. The `write()` method increased from 0.000674 to 0.001601 percent in the same period.

{{ figure_markup(
image="async-clipboard-api-page-loads.png",
caption='Percentage of page loads in Chrome using Async Clipboard API.<br>(Sources: <a hreflang="en" href="https://chromestatus.com/metrics/feature/timeline/popularity/2369">Async Clipboard Read</a>, <a hreflang="en" href="https://chromestatus.com/metrics/feature/timeline/popularity/2370">Async Clipboard Write</a>)',
description="Chart of Async Clipboard API usage, based on the percentage of page loads in Chrome using this feature. It compares the usage of the read and write methods, showing an exponential growth for read over the course of 2021, while write grows linear. In October 2021, read was called during 0.0029% of all page loads in Chrome, write for 0.0016%.",
chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQ5Byx-_990HdH35no6J879Vk-wNe6EJGHfJJEP61RuLYHyVJfRU0X0L96-kpFAEmWt7x4pB9aiMfQr/pubchart?oid=1933317785&format=interactive",
sheets_gid="1382342903"
)
}}

## File System Access API
The next productivity-related API is the [_File System Access API_](https://developer.mozilla.org/en-US/docs/Web/API/File_System_Access_API). Web apps could <a hreflang="en" href="https://web.dev/browser-fs-access/#the-traditional-way-of-dealing-with-files">already deal with files</a>: `<input type="file">` allows the user to open one or more files via a file picker. Also, they could already save files to the Downloads folder via `<a download>`. The File System Access API adds support for additional use cases: Opening and modifying directories, saving files to a location specified by the user, and overwriting files that were opened by them. It is also possible to persist file handles to `IndexedDB` to allow for continued (permission-gated) access, even after a page reload. In particular, the API does not grant random access to the file system and certain system folders are blocked by default.

### Write access
When calling the [`showSaveFilePicker()`](https://developer.mozilla.org/en-US/docs/Web/API/Window/showSaveFilePicker) method on the global `window` object, the browser will show the operating system's file picker. The method takes an optional options object where you can specify which file types are allowed for saving (`types`, default: all types), and whether the user can disable this filter via an "accept all" option (`excludeAcceptAllOption`, default: `false`).

When the user successfully picks a file from the local file system, you will receive its handle. With the help of the `createWritable()` method on the handle, you can access a stream writer. In the following example, this writer writes the text `hello world` to the file and closes it afterward.

```js
const handle = await window.showSaveFilePicker({
  types: [{
    description: 'PNG files',
    accept: { 'image/png': ['.png'] }
  }],
  excludeAcceptAllOption: true
});
const writable = await handle.createWritable();
await writable.write('hello world');
await writable.close();
```

### Read access
To show an open file picker, call the [`showOpenFilePicker()`](https://developer.mozilla.org/en-US/docs/Web/API/Window/showOpenFilePicker) method on the global `window` object. This method also takes an optional options object with the same properties from above (`types`, `excludeAcceptAllOption`). Additionally, you can specify if the user can select one or multiple files (`multiple`, default: `false`).

As the user could potentially select more than one file, you will receive an array of file handles. Using the array destructuring expression `[handle]`, you will receive the handle of the first selected file as the first element in the array. By calling the `getFile()` method on the file handle, you will receive a `File` object which gives you access to the file's binary data. By calling the `text()` method, you will receive the plain text from the opened file.

```js
const [handle] = await window.showOpenFilePicker({
  multiple: false
});
const blob = await handle.getFile();
const text = await blob.text();
console.log(text);
```

### Opening directories
Finally, the API allows web apps (e.g., integrated development environments) to get a handle for an entire directory. Using this handle, you can create, update, or delete existing files or folders within the opened directory. This time, the method is called [`showDirectoryPicker()`](https://developer.mozilla.org/en-US/docs/Web/API/window/showDirectoryPicker):

```js
const handle = await window.showDirectoryPicker();
```

The File System Access API is only available on Chromium-based browsers and desktop systems (<a hreflang="en" href="https://caniuse.com/native-filesystem-api">current browser support for the File System Access API</a>). Fortunately, the web platform offers the aforementioned fallback approaches to provide similar functionality on mobile devices and other browsers. Developers can use the Google-developed library <a hreflang="en" href="https://github.com/GoogleChromeLabs/browser-fs-access">browser-fs-access</a> that uses the File System Access API if present and otherwise falls back to the alternative implementation.

{{ figure_markup(
caption="Desktop websites using the File System Access API.",
content="29",
classes="big-number",
sheets_gid="2077755325",
sql_file="fugu.sql"
)
}}

Out of all 6,286,373 desktop and 7,491,840 mobile websites in the HTTP Archive, the File System Access API is used on 29 desktop and 23 mobile sites. Examples for those sites are the image editor <a hreflang="en" href="https://excalidraw.com/">Excalidraw</a>, which allows you to sketch diagrams in a hand-drawn look and save them to the disk. Another example is <a hreflang="en" href="https://coreldraw.app/">CorelDRAW.app</a>, a web version of the image editing software CorelDRAW.

{{ figure_markup(
image="file-system-access-api.jpg",
caption='The Excalidraw PWA uses the File System Access API to save images to the local file system via the built-in save dialog.',
description='Screenshot showing the Excalidraw drawing application with an open file save dialog.',
width=656,
height=409
) }}

## Web Share API
The [_Web Share API_](https://developer.mozilla.org/en-US/docs/Web/API/Navigator/share) allows you to share text, a URL, or files from a website or web application with other applications, e.g., mail clients or messengers. To do so, call the [`navigator.share()`](https://developer.mozilla.org/en-US/docs/Web/API/Navigator/share) method. It takes an object with the data to share with another application. The browser then opens the built-in share sheet, where the user can select the target application from. The method returns a promise that resolves in case the content was successfully shared; otherwise, it will be rejected.

```js
await navigator.share({
  files: picturesArray,
  title: 'Holiday pictures',
  text: 'Our holiday in the French Alps'
})
```

The Web Share API is supported by Safari on iOS and macOS, and Chrome and Edge on Windows and Chrome OS (<a hreflang="en" href="https://caniuse.com/web-share">current browser support for the Web Share API</a>). It's currently a <a hreflang="en" href="https://www.w3.org/TR/web-share/">Working Draft</a> at the Web Applications Working Group. This is one of the first stages of the track to becoming a W3C Recommendation.

{{ figure_markup(
caption="Desktop websites using the Web Share API.",
content="566,049",
classes="big-number",
sheets_gid="2077755325",
sql_file="fugu.sql"
)
}}

With 566,049 (9.00%) desktop and 642,507 (8.58%) mobile sites, the Web Share API is the most used Fugu API. For example, the <a hreflang="en" href="https://beta.paintz.app/">beta version of the PaintZ app</a> allows you to share a drawing with another locally installed application via the save dialog.

The high usage of this API is probably related to a script that is included with embedded YouTube videos. If the Web Share API is available on the device, it is executed when the user clicks the "Share" button in the video player.

{{ figure_markup(
image="web-share-api.jpg",
caption='The beta version of PaintZ uses the Web Share API to share drawings with local applications.',
description='Screenshot showing the PaintZ drawing application with an overlay of the built-in messaging application that received the drawing from the app.',
width=676,
height=419
) }}

In recent months, the overall use of the Web Share API has increased: The Chrome Platform Status data shows a rather linear growth in the period from November 2020, where the API was called on 0.0097% of all page loads, to 0.0136% in October 2021.

{{ figure_markup(
image="web-share-api-page-loads.png",
caption='Percentage of page loads in Chrome using Web Share API. (<a hreflang="en" href="https://chromestatus.com/metrics/feature/timeline/popularity/1501">Source</a>)',
description="Chart of Web Share API usage, based on the percentage of page loads in Chrome using this feature. It shows a rather linear growth in the period from November 2020 to October 2021: in November 2020, the API was called on 0.0097% of all page loads, in October 2021 on 0.0136% of all page loads.",
chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQ5Byx-_990HdH35no6J879Vk-wNe6EJGHfJJEP61RuLYHyVJfRU0X0L96-kpFAEmWt7x4pB9aiMfQr/pubchart?oid=2113981194&format=interactive",
sheets_gid="1372715282"
)
}}

## URL Handlers and Declarative Link Capturing
The last two productivity-related capabilities described in this chapter are _URL Handlers_ and _Declarative Link Capturing_, additional methods for even deeper integration with the operating system.

### URL Handling
With the help of <a hreflang="en" href="https://web.dev/pwa-url-handler/">URL Handling</a>, PWAs can register themselves as handlers for certain URL schemes upon installation, e.g., for `https://*.example.com`. When the user opens a URL that matches this scheme, the installed PWA will open instead of a new browser tab. URL Handling is an extension of the <a hreflang="en" href="https://www.w3.org/TR/appmanifest/">_Web Application Manifest_</a>, a file that contains [metadata for web applications](https://developer.mozilla.org/en-US/docs/Web/Manifest). To register for URL schemes, you have to add the `url_handlers` property to your manifest. This property takes an array containing objects with an `origin` property.

```json
{
  "url_handlers": [{
    "origin": "https://*.example.com"
  }]
}
```

If you want to register for origins other than your web app's origin, you need to <a hreflang="en" href="https://web.dev/pwa-url-handler/#the-web-app-origin-association-file">verify your ownership of them</a>. The capability is at a relatively early stage: it's only supported on Chrome and Edge on the desktop. URL Handling is currently available as an <a hreflang="en" href="https://developer.chrome.com/blog/origin-trials/">Origin Trial</a>. This means that the capability is not generally available yet. Instead, developers need to opt-in to using this experimental API by registering for an Origin Trial token first and deliver this token along with their website to use this capability. You can find more information in the <a hreflang="en" href="https://github.com/GoogleChrome/OriginTrials/blob/gh-pages/developer-guide.md">Origin Trials Guide for Web Developers</a>.

{{ figure_markup(
caption="Desktop websites use URL Handling.",
content="44",
classes="big-number",
sheets_gid="2077755325",
sql_file="fugu.sql"
)
}}

44 desktop and 41 mobile websites make use of URL Handling. For example, the Pinterest PWA registers itself as a URL handler for the different Pinterest origins (e.g., `*.pinterest.com` and `*.pinterest.de`) on installation.

### Declarative Link Capturing
With the help of <a hreflang="en" href="https://web.dev/declarative-link-capturing/">Declarative Link Capturing</a>, you can further control how PWAs should behave when the user opens them. For instance, an office application may want to open another window for a new document, while a music player wants to keep its single window open. Therefore, Declarative Link Capturing defines three different modes:

1. `none` does not capture the link at all (the default)
2. `new-client` opens a new window for the PWA
3. `existing-client-navigate`  navigates an existing client to the new URL or opens a new window if no client exists

Declarative Link Capturing also is an extension of the Web Application Manifest. To use it, you need to add the `capture_links` property to your manifest. This property takes a string or an array of strings matching the three modes from above. If you use an array, the browser will fall back to the next entry if it doesn't support a particular mode.

```json
{
  "capture_links": [
    "existing-client-navigate",
    "new-client",
    "none"
  ]
}
```

{{ figure_markup(
caption="Desktop websites use Declarative Link Capturing.",
content="36",
classes="big-number",
sheets_gid="2077755325",
sql_file="fugu.sql"
)
}}

This capability is at an early stage as well. It is only supported on Chrome OS. Currently, 36 desktop sites and 11 mobile sites use this capability, for example, <a hreflang="en" href="https://periodex.co/">Periodex</a>, a PWA showing the periodic table of elements. This app uses the `capture_links` configuration as shown in the listing above meaning that, if supported, the browser should reuse the existing window, otherwise, open a new one, and if that's not supported, it should behave as normal.

## Hardware APIs
The next set of capabilities focuses on hardware-related APIs. In Chromium-based browsers, there are many APIs to access hardware interfaces, including but not limited to USB, Bluetooth, and serial devices. Furthermore, the Generic Sensor API allows you to read from device sensors. All capabilities discussed in this section are only available on Chromium-based browsers and on systems where the respective hardware interface or sensor is present.

### Web USB API
The <a hreflang="en" href="https://web.dev/usb/">_Web USB API_</a> allows developers to access USB devices without any drivers or third-party applications. For instance, this capability is interesting for firmware updates that developers otherwise would have to implement as separate platform-specific apps for different platforms. You need to call the `navigator.usb.requestDevice()` method to access USB devices. It takes an object which defines filters for the list of all connected USB devices. You need to specify the `vendorId` at least. The browser shows a device picker where the user can choose a matching device. From there, you can begin a device session.

```js
try {
  const device = await navigator.usb.requestDevice({
    filters: [{ vendorId: 0x8086 }]
  });
  console.log(device.productName);
  console.log(device.manufacturerName);
} catch (err) {
  console.log(err);
}
```

{{ figure_markup(
caption="Desktop websites use Web USB.",
content="182",
classes="big-number",
sheets_gid="2077755325",
sql_file="fugu.sql"
)
}}

The API has been generally available on Chromium-based browsers since version 61 (<a hreflang="en" href="https://caniuse.com/webusb">current browser support for the Web USB API</a>). 182 desktop and 155 mobile sites use this API, for example, the PWA <a hreflang="en" href="https://app.vysor.io/#/">Vysor</a> that allows you to mirror the screen of an Android or iOS device—all without installing any additional software on your computer.

{{ figure_markup(
image="web-usb.jpg",
caption='The Vysor PWA uses Web USB to connect to USB devices and project their screen contents onto the desktop.',
description='Screenshot of the Vysor web application with a modal dialog open listing the connected USB devices.',
width=699,
height=440
) }}

### Web Bluetooth API
The <a hreflang="en" href="https://web.dev/bluetooth/">_Web Bluetooth API_</a> allows you to communicate with nearby Bluetooth Low Energy devices using the <a hreflang="en" href="https://www.bluetooth.com/bluetooth-resources/intro-to-bluetooth-gap-gatt/">Generic Attribute Profile (GATT)</a>. To find a matching device, call the `navigator.bluetooth.requestDevice()` method. In the following example, the list of Bluetooth devices is filtered by whether they offer a battery service or not. The browser shows a device picker where the user can choose a Bluetooth device. Afterward, you can connect to the remote device and gather the data.

```js
try {
  const device = await navigator.bluetooth.requestDevice({
    filters: [{ services: ['battery_service'] }]
  });
  console.log(device.name);
} catch (err) {
  console.log(err);
}
```

{{ figure_markup(
caption="Desktop websites using the Web Bluetooth API.",
content="71",
classes="big-number",
sheets_gid="2077755325",
sql_file="fugu.sql"
)
}}

The API is generally available on Chromium-based browsers on Chrome OS, Android, macOS, and Windows starting from version 56 (<a hreflang="en" href="https://caniuse.com/web-bluetooth">current browser support for the Web Bluetooth API</a>). On Linux, the API is provided behind a flag. 71 desktop and 45 mobile sites make use of this capability. For instance, the <a hreflang="en" href="https://web.brewfather.app/">Brewfather</a> PWA targeted at home brewers allows them to send a beer recipe wirelessly over to a Bluetooth-enabled brewing system. Again, all without installing any third-party software.

{{ figure_markup(
image="web-bluetooth.jpg",
caption='The Brewfather app uses Web Bluetooth to send recipes to a brew controller.',
description='Screenshot showing the Brewfather web application that displays a beer recipe, and the ability to start brewing.',
width=699,
height=440
) }}

### Web Serial API
The <a hreflang="en" href="https://web.dev/serial/">_Web Serial API_</a> allows you to connect with serial devices such as microcontrollers. To do so, call the `navigator.serial.requestPort()` method. You can optionally pass in a method to filter the device list. The browser shows a device picker where the user can choose a device. Next, you can open the connection by calling the port's `open()` method.

```js
try {
  const port = await navigator.serial.requestPort();
  await port.open({ baudRate: 9600 });
} catch (err) {
  console.log(err);
}
```

{{ figure_markup(
caption="Desktop websites using the Web Serial API.",
content="15",
classes="big-number",
sheets_gid="2077755325",
sql_file="fugu.sql"
)
}}

This capability is relatively new, as it shipped with Chromium 89 in March 2021 (<a hreflang="en" href="https://caniuse.com/web-serial">current browser support for the Web Serial API</a>). Currently, 15 desktop and 14 mobile sites use the Web Serial API, including the <a hreflang="en" href="https://duino.app/">Duino App</a> that allows you to develop programs for Arduino and ESP microcontrollers right in your browser. They are compiled on a remote server and then uploaded to a connected board via the Web Serial API.

{{ figure_markup(
image="web-serial.jpg",
caption='The Duino app is a web-based IDE that uses Web Serial to upload programs to Arduino microcontrollers.',
description='Screenshot showing the web-based Duino code editor application compiling code.',
width=699,
height=440
) }}

### Generic Sensor API
Finally, the <a hreflang="en" href="https://web.dev/generic-sensor/">_Generic Sensor API_</a> allows you to read sensor data from the device's sensors, such as the accelerometer, gyroscope, or orientation sensor. To access a sensor, you create a new instance of a sensor class, e.g., `Accelerometer`. The constructor takes a configuration object with the requested frequency. By attaching to the `onreading` and `onerror` events, you can get notified for updated sensor values, or errors respectively. Finally, you need to start the reading by calling the `start()` method.

```js
try {
  const accelerometer = new Accelerometer({ frequency: 10 });
  accelerometer.onerror = (event) => {
    console.log(event);
  };
  accelerometer.onreading = (e) => {
    console.log(e);
  };
  accelerometer.start();
} catch (err) {
  console.log(err);
}
```

{{ figure_markup(
image="generic-sensor-api-usage.png",
caption='Usage of Generic Sensor APIs on desktop and mobile websites.',
description="Chart showing the use of the Generic Sensor API. It compares three different sensor APIs: The relative orientation sensor is the most used with 824 desktop and 831 mobile sites. The linear acceleration sensor follows far behind with 257 desktop and 237 mobile sites. The gyroscope is used the least with 36 desktop and 22 mobile sites.",
chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vQ5Byx-_990HdH35no6J879Vk-wNe6EJGHfJJEP61RuLYHyVJfRU0X0L96-kpFAEmWt7x4pB9aiMfQr/pubchart?oid=1901915946&format=interactive",
sheets_gid="2077755325",
sql_file="fugu.sql"
)
}}

The capability is supported by Chromium browsers starting from version 67 (<a hreflang="en" href="https://caniuse.com/mdn-api_sensor">current browser support for the Generic Sensor API</a>). The relative orientation sensor is used by 824 desktop and 831 mobile sites, the linear acceleration sensor by 257 desktop and 237 mobile sites, and the gyroscope by 36 desktop and 22 mobile sites. An example application that uses all three of them is <a hreflang="en" href="https://obs.ninja/">VDO.Ninja</a>, the former OBS Ninja. This software allows you to remotely connect with video broadcasting software such as OBS. The app allows the connected broadcasting software to read sensor data from the device. For example, to capture a smartphone's movements when streaming virtual reality content. Fugu contributor Intel provides additional <a hreflang="en" href="https://intel.github.io/generic-sensor-demos/">demos for the Generic Sensor API</a>.

{{ figure_markup(
image="generic-sensor-api.jpg",
caption='The Generic Sensor API can be used to rotate 3D models according to the orientation of the device.',
description='Two screenshots of a cell phone showing a 3D model. In the second screenshot, the 3D model has been rotated because the orientation of the device has changed.',
width=808,
height=822
) }}

## Sites using the most capabilities
The analysis also identified the websites using the most capabilities from the HTTP Archive data set. The detection script is capable of identifying 30 Fugu APIs in total. So, let's give an award to the websites that use the most Fugu APIs. The excitement is building!

{{ figure_markup(
image="fugu-podium.jpg",
caption='The three websites that use the most Fugu APIs.',
description="The image shows a winner's podium with screenshots of the three websites that use the most Fugu APIs.",
width=1050,
height=442
) }}

1. The first place goes to <a hreflang="en" href="https://whatwebcando.today/">whatwebcando.today</a>, which uses 28 capabilities. It showcases different HTML5 device integration APIs by providing a live demo for every capability. Naturally, the number of used APIs is very high. In the result set, a similar site called <a hreflang="en" href="https://whatpwacando.today/">whatpwacando.today</a> showcases PWA capabilities and uses eight APIs.
1. The runner-up is the <a hreflang="en" href="https://polisnotis.se/">PolisNotis</a> PWA which shows police notices in Sweden. It uses ten APIs, including the Declarative Link Capturing API to define that the PWA should always open a new window when clicking a PWA-related link. The Web Share API is used in the source code, but the sharing functionality is not exposed to the UI. The app also uses the Badging API to alert the user via the app icon if there is a new notice.
1. Closely followed in third place is the website <a hreflang="en" href="https://system-scanner.net/">System Scanner</a>, that uses nine APIs: It shows an overview of the system information exposed by the browser, including sensor information provided by the Generic Sensor API.
1. Eight sites use eight Fugu APIs: One of them is the aforementioned <a hreflang="en" href="https://excalidraw.com/">Excalidraw</a>, an online drawing tool for creating drawings in a hand-drawn style. As a traditional productivity app, it benefits from the new capabilities.

Some websites from the result set are Internet forums based on <a hreflang="en" href="https://www.discourse.org/">Discourse</a>. This forum software supports a total of eight Fugu APIs. Discourse-based forums are installable and support, among others, the Badging API to show the number of unread notifications.

The results also include sites that aren't proactively using the APIs. For example, some sites ship library code that could theoretically access the capabilities. Some sites check for the presence of Fugu APIs to determine the user's browser.

## Conclusion
Capabilities help move the web forward by unlocking more and more use cases for developers. As this chapter shows, developers use the new web platform APIs to build powerful applications. In contrast to their platform-specific counterparts, those applications don't necessarily need to be installed to the system and don't require any additional third-party runtimes or plugins to work. They run on any platform that can run a powerful browser.

One example of this concept working is Visual Studio Code. This application has always been web-based, but it still relied on platform-specific application wrappers like Electron. Thanks to capabilities like the File System Access API, Microsoft was able to release the application as a browser application (<a hreflang="en" href="https://vscode.dev">vscode.dev</a>) in October 2021. Almost all features work here, except debugging or terminal access since there is no capability for this (yet!).

Another example is <a hreflang="en" href="https://photoshop.adobe.com">Adobe Photoshop</a>, which was also <a hreflang="en" href="https://web.dev/ps-on-the-web/">released as a web application</a> in October 2021. Photoshop uses several of the capabilities presented here, as well as WebAssembly, to migrate existing code to the web. Its vector-based counterpart Illustrator is currently available as a closed beta and will be released at a later date. While the first editions will still have a limited feature set, Adobe has already announced that it won't stop there, but that <a hreflang="en" href="https://web.dev/ps-on-the-web/#what's-next-for-adobe-on-the-web">further expansion to the web is planned</a>.

Thus, the Capabilities project paves the way for entire categories of applications to finally migrate to the web.
