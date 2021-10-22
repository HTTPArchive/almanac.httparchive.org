---
#See https://github.com/HTTPArchive/almanac.httparchive.org/wiki/Authors'-Guide#metadata-to-add-at-the-top-of-your-chapters
title: Capabilities
description: TODO
authors: [christianliebel]
reviewers: [tomayac, hemanth]
analysts: [tomayac]
editors: []
translators: []
results: https://docs.google.com/spreadsheets/d/1b4moteB9EiLYkH1Ln9qfi1tnU-E4N2UQ87uayWytDKw/
christianliebel_bio: Christian Liebel is a consultant at <a hreflang="en" href="https://thinktecture.com">Thinktecture</a>, supporting clients from various business areas in implementing first-class web applications. He is a Microsoft MVP for Developer Technologies, Google GDE for Web/Capabilities and Angular, and participates in the W3C Web Applications Working Group.
featured_quote: TODO
featured_stat_1: TODO
featured_stat_label_1: TODO
featured_stat_2: TODO
featured_stat_label_2: TODO
featured_stat_3: TODO
featured_stat_label_3: TODO
---

## Capabilities
Capabilities are new web platform APIs that unlock entirely new use cases for web applications. Those new APIs are essential for [Progressive Web Apps (PWA)](../pwa), a web-based application model. A PWA is a web app that users can install to their system, runs even offline, and launches quickly. To integrate with the underlying operating system, PWAs can only use web platform APIs. While browsers have already exposed some native features to the web (e.g., geolocation, gamepad, or webcam access), many APIs were still missing (e.g., file system or clipboard access).

The [Capabilities Project](https://www.chromium.org/teams/web-capabilities-fugu) (codename Fugu) is a joint effort by Microsoft, Intel, Google, and other Chromium contributors. It tries to bridge the gap between native applications and web apps by designing and implementing new powerful web platform APIs in a secure and privacy-preserving manner. As capabilities unlock more and more use cases, they lay the path for entire new application categories to finally make the shift to the web (e.g., IDEs, image editors, or office applications). Over the last two years, the focus for the Fugu team has been on capabilities for desktop productivity applications and hardware-related APIs. This chapter briefly introduces several new capabilities and analyzes how many different desktop and mobile websites use them. As capabilities are particularly interesting for app-like websites, their relative usage is comparatively low. This is why we are using absolute website numbers in this chapter. For each capability, we will show you a demo website or app that makes use of it.

This chapter uses the HTTP Archive data set. For security reasons, some APIs require a user gesture (i.e., a click or keypress) to function. As the HTTP Archive crawler does not support detecting those APIs during runtime, the source code of the websites is parsed instead: For instance, the regular expression `/navigator\.share\s*\(/g` is matched against the website’s source code to determine if it makes use of the Web Share API. This method is not perfectly accurate, as it doesn’t measure the actual use of an API, and developers may invoke an API using a different syntax. However, this approach should provide a sufficiently good overview. You can find the exact regexes for the 30 supported capabilities [in this source file](https://github.com/HTTPArchive/legacy.httparchive.org/blob/master/custom_metrics/fugu-apis.js). All usage data in this chapter is based on the July 2021 crawl. You can find the raw data in the [Capabilities 2021 Results Sheet](https://docs.google.com/spreadsheets/d/1b4moteB9EiLYkH1Ln9qfi1tnU-E4N2UQ87uayWytDKw/edit#gid=2077755325).

Please note that most of the APIs presented here are so-called incubations. Unless noted, they are not (yet) W3C Recommendations, i.e., official web standards. Instead, these APIs are being worked on in the Web Platform Incubator Community Group (WICG), where browser vendors and developers can discuss new features. Some APIs have already shipped in several browsers; others are only available on Chromium-based ones. These browsers include Google Chrome, Microsoft Edge, Opera, Brave, or Samsung Internet. Please note that vendors of Chromium-based browsers can choose to disable specific capabilities, so not all APIs may be available in all browsers based on Chromium. Some capabilities may only be available after activating a flag in the browser settings.

### File System Access API
The first productivity-related API is the [File System Access API](https://developer.mozilla.org/en-US/docs/Web/API/File_System_Access_API). It allows your application to access the user’s file system securely: The user can select one or more files they want to give the web app access via a file picker. In particular, the API does not grant random access to the file system. When the user has selected a file, the application can either create it (in case it didn’t exist before) or modify its contents.

#### Write Access
When calling the `showSaveFilePicker()` method on the global window object, the browser will show a native file picker. When the user successfully picks a file from the local file system, you will receive its handle. With the help of the `createWritable()` method on the handle, you can access a stream writer. In the following example, this writer writes the text `hello world` to the file and closes it afterward.

```js
const handle = await window.showSaveFilePicker();
const writable = await handle.createWritable();
await writable.write('hello world');
await writable.close();
```

#### Read Access
To show an open file picker, call the `showOpenFilePicker()` method on the global window object. This time, the user could potentially select more than one file. As a result, you will receive an array of file handles. Using the destructuring expression `[handle]`, you will receive the handle of the first selected file as the first element in the array. By calling the `getFile()` method on the file handle, you will receive a File object which gives you access to the file’s binary data. By calling the `text()` method, you will receive the plain text from the opened file.

```js
const [handle] = await window.showOpenFilePicker();
const blob = await handle.getFile();
const text = await blob.text();
console.log(text);
```

#### Opening Directories
Furthermore, the API allows web apps (e.g., integrated development environments) to get a handle for an entire directory. Using this handle, you can create, update or delete existing files or folders within the opened directory. This time, the method is called `showDirectoryPicker()`:

```js
const handle = window.showDirectoryPicker();
```

The File System Access API is only available on Chromium-based browsers and desktop systems. Fortunately, the web platform offers fallback approaches to provide similar functionality on mobile devices and other browsers as well: With the `input[type=file]` control, it’s possible to give a web application access to the binary contents of a file. The `a[download]` mechanism allows users to download a dynamically generated file to their Downloads folder. Developers can also use Thomas Steiner’s library [browser-fs-access](https://github.com/GoogleChromeLabs/browser-fs-access) that uses File System Access API if present and otherwise falls back to the alternative implementation.

Out of all 6,286,373 desktop and 7,491,840 mobile websites in the HTTP Archive, the File System Access API is used on 29 desktop and 23 mobile sites. Examples for those sites are the image editor [Excalidraw](https://excalidraw.com/), which allows you to sketch diagrams in a hand-drawn look and save them to the disk. Another example is [CorelDRAW.app](https://coreldraw.app/), a web version of the image editing software CorelDRAW.

### Async Clipboard API
The [Async Clipboard API](https://developer.mozilla.org/en-US/docs/Web/API/Clipboard_API) allows you to read and write data from or to the clipboard. Due to its asynchronous nature, it enables use cases like scaling down an image while pasting it—all without blocking the UI. It replaces less capable APIs like `document.execCommand()` that were previously used to interact with the clipboard.

#### Write Access
The Async Clipboard API offers two methods to copy data to the clipboard: The shorthand method `writeText()` takes plain text as an argument which the browser then copies to the clipboard. The `write()` method takes an array of clipboard items that could contain arbitrary data. WebKit currently restricts the supported data formats to plain text, HTML, URL lists, and PNG images.

```js
await navigator.clipboard.writeText('hello world');
await navigator.clipboard.write([new ClipboardItem('hello world')]);
```

#### Read Access
Similar to copying data to the clipboard, there are two methods to paste data back from the clipboard: First, another shorthand method called `readText()` that returns plain text from the clipboard. Using the `read()` method, you access all items in the clipboard in the data formats supported by the browser.

```js
const item = await navigator.clipboard.readText();
const items = await navigator.clipboard.read();
```

The browser may show a permission prompt or a different UI for privacy reasons before granting the website access to the clipboard contents. The Async Clipboard API is available in Chrome, Edge, and Safari. Firefox only supports the `writeText()` method.

With 560,359 (8.91%) desktop and 618,062 (8.25%) mobile sites, the Async Clipboard API (`writeText()` method) is one of the most used Fugu APIs. The `write()` method is used on 1,180 desktop and 1,227 mobile sites. The commercial website [Clipping Magic](https://clippingmagic.com/) allows you to remove the background of an image with the help of an AI algorithm. Just paste an image from the clipboard, and the website will remove its background.

### Web Share API
The [Web Share API](https://developer.mozilla.org/en-US/docs/Web/API/Navigator/share) allows you to share text, a URL, or files from a website or web application with other applications, e.g., mail clients or messengers. To do so, call the `navigator.share()` method. It takes an object with the data to share with another application. The browser then opens the native share sheet, where the user can select the target application from. The method returns a promise that resolves in case the content was successfully shared; otherwise, it will be rejected.

```js
await navigator.share({
  files: picturesArray,
  title: 'Holiday pictures',
  text: 'Our holiday in the French Alps'
})
``` 

The Web Share API is supported by Safari (iOS, macOS), and Chrome and Edge (Windows, Chrome OS). It’s currently a [Working Draft](https://www.w3.org/TR/web-share/) at the Web Applications Working Group. This is one of the first stages of the track to becoming a W3C Recommendation.

With 566,049 (9.00%) desktop and 642,507 (8.58%) mobile sites, the Web Share API is the most used Fugu API. For example, the [beta version of the PaintZ app](https://beta.paintz.app/) allows you to share a drawing with another locally installed application via the save dialog.

### URL Handlers and Declarative Link Capturing
The last two productivity-related capabilities described in this chapter are URL Handlers and Declarative Link Capturing, additional methods for even deeper integration with the operating system.

#### URL Handling
With the help of [URL Handling](https://web.dev/pwa-url-handler/), PWAs can register themselves as handlers for certain URL schemes upon installation, e.g., for `https://*.example.com`. When the user opens a URL that matches this scheme, the installed PWA will open instead of a new browser tab. URL Handling is an extension of the [Web Application Manifest](https://www.w3.org/TR/appmanifest/), a file that contains metadata for web applications. To register for URL schemes, you have to add the `url_handlers` property to your manifest. This property takes an array containing objects with an `origin` property.

```json
{
  "url_handlers": [{
    "origin": "https://*.example.com"
  }]
}
```

If you want to register for origins other than your web app’s origin, you need to [verify your ownership of them](https://web.dev/pwa-url-handler/#the-web-app-origin-association-file). The capability is at a relatively early stage: It’s only supported on Chrome and Edge on the desktop. URL Handling is currently available as an Origin Trial. This means that the capability is not generally available yet. Instead, developers need to register for an Origin Trial token first and deliver this token along with their website to use this capability. You can find more information in the [Origin Trials Guide for Web Developers](https://github.com/GoogleChrome/OriginTrials/blob/gh-pages/developer-guide.md).

44 desktop and 41 mobile websites make use of URL Handling. For example, the Pinterest PWA registers itself as a URL handler for the different Pinterest origins (e.g., `*.pinterest.com` and `*.pinterest.de`) on installation.

#### Declarative Link Capturing
With the help of [Declarative Link Capturing](https://web.dev/declarative-link-capturing/), you can further control how PWAs should behave when the user opens them. For instance, an office application may want to open another window for a new document, while a music player wants to keep its single window open. Therefore, Declarative Link Capturing defines three different modes:

1. `none` does not capture the link at all (the default)
2. `new-client` opens a new window for the PWA
3. `existing-client-navigate`  navigates an existing client to the new URL or opens a new window if no client exists

Declarative Link Capturing also is an extension of the Web Application Manifest. To use it, you need to add the `capture_links` property to your manifest. This property takes a string or an array of strings matching the three modes from above. If you use an array, the browser will fall back to the next entry if it doesn’t support a particular mode.

```json
{
  "capture_links": [
    "existing-client-navigate",
    "new-client",
    "none"
  ]
}
```

This capability is at an early stage as well. It is only supported on Chrome OS. Currently, 36 desktop sites and 11 mobile sites use this capability, for example, [Periodex](https://periodex.co/), a PWA showing the periodic table of elements. This app uses the `capture_links` configuration as shown in the listing above: If supported, the browser should reuse the existing window, otherwise, open a new one, and if that’s not supported, it should behave as normal.

### Hardware APIs
The next set of capabilities focuses on hardware-related APIs. In Chromium-based browsers, there are many APIs to access hardware interfaces, including but not limited to USB, Bluetooth, and serial devices. Furthermore, the Generic Sensor API allows you to read from device sensors. All capabilities discussed in this section are only available on Chromium-based browsers and on systems where the respective hardware interface or sensor is present.

#### Web USB API
The [Web USB API](https://web.dev/usb/) allows developers to access USB devices without any drivers or third-party applications. For instance, this capability is interesting for firmware updaters that developers otherwise would have to implement as separate native apps for different platforms. You need to call the `navigator.usb.requestDevice()` method to access USB devices. It takes an object which defines filters for the list of all connected USB devices. You need to specify the `vendorId` at least. The browser shows a device picker where the user can choose a matching device. From there, you can begin a device session.

```js
try {
  const device = await navigator.usb.requestDevice({ filters: [{ vendorId: 0x8086 }] });
  console.log(device.productName);
  console.log(device.manufacturerName);
} catch (err) {
  console.log(err);
}
```

The API is generally available on Chromium-based browsers since version 61. 182 desktop and 155 mobile sites use this API, for example, the PWA [Vysor](https://app.vysor.io/#/) that allows you to mirror the screen of an Android or iOS device—all without installing any additional software on your computer.

#### Web Bluetooth API
The [Web Bluetooth API](https://web.dev/bluetooth/) allows you to communicate with nearby Bluetooth Low Energy devices using the Generic Attribute Profile (GATT). To find a matching device, call the `navigator.bluetooth.requestDevice()` method. In the following example, the list of Bluetooth devices is filtered by whether they offer a battery service or not. The browser shows a device picker where the user can choose a Bluetooth device. Afterward, you can connect to the remote device and gather the data.

```js
try {
  const device = await navigator.bluetooth.requestDevice({ filters: [{ services: ['battery_service'] }] });
  console.log(device.name);
} catch (err) {
  console.log(err);
}
```

The API is generally available on Chromium-based browsers on Chrome OS, Android, macOS, and Windows starting from version 56. On Linux, the API is provided behind a flag. 71 desktop and 45 mobile sites make use of this capability. For instance, the [Brewfather](https://web.brewfather.app/) PWA targeted at home-brewers allows them to send a beer recipe wirelessly over to a Bluetooth-enabled brewing system. Again, all without installing any third-party software.

#### Web Serial API
The [Web Serial API](https://web.dev/serial/) allows you to connect with serial devices such as microcontrollers. To do so, call the `navigator.serial.requestPort()` method. You can optionally pass in a method to filter the device list. The browser shows a device picker where the user can choose a device. Next, you can open the connection by calling the port’s `open()` method.

```js
try {
  const port = await navigator.serial.requestPort();
  await port.open({ baudRate: 9600 });
} catch (err) {
  console.log(err);
}
```

This capability is relatively new, as it shipped with Chromium 89 in March 2021. Currently, 15 desktop and 14 mobile sites use Web Serial API, including the [Duino App](https://duino.app/) that allows you to develop programs for Arduino and ESP microcontrollers right in your browser. They are compiled on a remote server and then uploaded to a connected board via the Web Serial API.

#### Generic Sensor API
Finally, the [Generic Sensor API](https://web.dev/generic-sensor/) allows you to read sensor data from the device’s sensors, such as the accelerometer, gyroscope, or orientation sensor. To access a sensor, you create a new instance of a sensor class, e.g., `Accelerometer`. The constructor takes a configuration object with the requested frequency. By attaching to the `onreading` and `onerror` events, you can get notified for updated sensor values, or errors respectively. Finally, you need to start the reading by calling the `start()` method.

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

The capability is supported by Chromium browsers starting from version 67. The relative orientation sensor is used by 824 desktop and 831 mobile sites, the linear acceleration sensor by 257 desktop and 237 mobile sites, and the gyroscope by 36 desktop and 22 mobile sites. An example application that uses all three of them is [VDO.Ninja](https://obs.ninja/), the former OBS Ninja. This software allows you to remotely connect with video broadcasting software such as OBS. The app allows the connected broadcasting software to read sensor data from the device.  For example, to capture a smartphone’s movement when streaming virtual reality content.

### Sites using most capabilities
The analysis also identified the websites using the most capabilities from the HTTP Archive data set. The crawler is capable of identifying 30 Fugu APIs in total.

1. The number one site is [whatwebcando.today](https://whatwebcando.today/), which uses 28 capabilities. It showcases different HTML5 device integration APIs by providing a live demo for every capability. Naturally, the number of used APIs is very high. In the result set, a similar site called [whatpwacando.today](https://whatpwacando.today/)  showcases PWA capabilities and uses eight APIs.
2. The [PolisNotis](https://polisnotis.se/) PWA shows police notices in Sweden. It uses ten APIs, including the Declarative Link Capturing API to define that the PWA should always open a new window when clicking a PWA-related link. The Web Share API is used in the source code, but the sharing functionality is not exposed to the UI.
3. The website [System Scanner](https://system-scanner.net/) uses nine APIs: It shows an overview of the system information exposed by the browser, including sensor information provided by the Generic Sensor API.
4. Eight sites use eight Fugu APIs: One of them is the aforementioned [Excalidraw](https://excalidraw.com/), an online drawing tool for creating drawings in a hand-drawn style. As a traditional productivity app, it benefits from the new capabilities.

The results also include sites that aren’t proactively using the APIs. For example, some sites ship library code that could theoretically access the capabilities. Some sites check for the presence of Fugu APIs to determine the user’s browser.

### Conclusion
Capabilities help move the web forward by unlocking more and more use cases for developers. As this chapter shows, developers use the new web platform APIs to build powerful applications. In contrast to their native counterparts, those applications don’t need to be installed to the system and don’t require any additional third-party runtimes or plug-ins to work. They run on any platform that can run a powerful browser.

One example of this concept working is the Visual Studio Code IDE. This application has always been web-based, but it still relied on native application wrappers like Electron. Thanks to capabilities like the File System Access API, Microsoft was able to release the application as a browser application ([vscode.dev](https://vscode.dev)) in October 2021. Almost all IDE features work here, except access to the terminal, since there is no capability for this yet.
