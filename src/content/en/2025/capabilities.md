---
#See https://github.com/HTTPArchive/almanac.httparchive.org/wiki/Authors'-Guide#metadata-to-add-at-the-top-of-your-chapters
title: Capabilities
description: Capabilities chapter of the 20202522 Web Almanac covering brand-new, powerful web platform APIs that give web apps access to hardware interfaces, enhance web-based productivity apps, and more.
hero_alt: Hero image of Web Almanac characters with superhero capes plugging various capabilities into a web page.
authors: [Dawntraoz, MichaelSolati]
reviewers: [webmaxru]
analysts: [guaca, christianliebel]
editors: [tunetheweb]
translators: []
Dawntraoz_bio: TODO
MichaelSolati_bio: Michael is a Developer Advocate at Amplication, focusing on helping developers build APIs and drink IPAs. Additionally, he is a Web GDE and has found his love in creating compelling experiences on the web and the voodoo ways of the web.
results: https://docs.google.com/spreadsheets/d/1tBTCtkEw0QEOyebuHIettqGEKw1gtO2EB1jkwpRKb18
featured_quote: TODO
featured_stat_1: TODO
featured_stat_label_1: TODO
featured_stat_2: TODO
featured_stat_label_2: TODO
featured_stat_3: TODO
featured_stat_label_3: TODO
---

## Introduction

Today's web browsers offer a richer web experience than ever before. They are not limited to the basic capabilities of the browser itself; they also make use of lower-level features and the operating system on which they run.

These capabilities are made available via web platform APIs, including well-established ones such as [Clipboard](https://developer.mozilla.org/docs/Web/API/Clipboard_API), [File System](https://developer.mozilla.org/docs/Web/API/File_System_API) and [Service Worker](https://developer.mozilla.org/docs/Web/API/Service_Worker_API), as well as new ones in the experimental phase that will transform the creation of web pages.

In the age of AI, browsers cannot afford to be left behind — they must propose sustainable, accessible solutions for all, in order to democratize the use of AI. Consequently, we will see the initial use of these new Chrome-specific APIs in the 'Capabilities 2025' chapter this year.

## Methodology

This chapter used the HTTP Archive's public dataset of millions of pages. These pages were archived as if they were visited on both desktop and mobile, as some sites will serve different content based on what device is requesting the page.

The HTTP Archive's crawler then parsed the source code for all of these pages to determine which APIs were (potentially) used on the pages. For instance, regular expressions, such as `/navigator\.share\s*\(/g`, test pages to see if in the concrete case the Web Share API is found in its source code.

This method does have two significant issues. First, it may under-report some APIs used as it can not detect obfuscated code that may exist due to minification, for example, when navigator was minified to n. Additionally, it may over-report occurrences of APIs because it does not execute code to see if an API is actually used. Regardless of these limitations, this methodology should provide a sufficiently good overview of what capabilities are used on the web.

Seventy-five total regular expressions for supported capabilities exist; view <a hreflang="en" href="https://github.com/HTTPArchive/custom-metrics/blob/main/dist/fugu-apis.js">this source file</a> to see all the expressions used.

### Project Fugu

Before we dive into the data, I would like to express my gratitude to Project Fugu, a cross-company initiative aimed at achieving feature parity between web and mobile/desktop applications.

Thanks to this initiative, we can benefit from many features that belong to applications only by exposing platform-specific capabilities to the web.

If you would like to know which APIs are exposed in this context, please visit the Chrome Developers blog to find out more about the [Capabilities Project](https://developer.chrome.com/docs/capabilities).

## Top 7 most used features

{# TODO: Add intro #}

### Compression Streams API

The [Compression Streams API](https://developer.mozilla.org/docs/Web/API/Compression_Streams_API) allows web apps to compress and decompress data using widely supported formats like GZIP and Deflate, directly in the browser. This enables more efficient transfer and storage of large data without relying on server-side processing.

Data is processed via `CompressionStream` and `DecompressionStream` objects, which integrate with the web's streaming APIs (`ReadableStream`, `WritableStream`).

```js
const text = "Hello Web Almanac 2025!";
const stream = new Blob([text]).stream();
const compressed = stream.pipeThrough(new CompressionStream("gzip"));
const decompressed = compressed.pipeThrough(new DecompressionStream("gzip"));
const result = await new Response(decompressed).text();

console.log(result); // "Hello Web Almanac 2025!"
```

Since May 2023, this feature works across the latest devices and browser versions. Available in Chromium-based browsers, Safari and Firefox, but might not work in older devices or browsers.

{{ figure_markup(
  image="compression-streams.png",
  caption="Compression Streams API usage.",
  description="Bar chart showing a surge in Compression Streams API usage across both mobile and desktop platforms between 2024 and 2025. On mobile devices, usage skyrocketed from a mere 2.3% in 2024 to 12.3% in 2025, representing a more than fivefold increase. Desktop adoption followed an even steeper trajectory, jumping from 2.7% to 14.0% over the same one-year period.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vSyxDgchtyy-8NISa8hPX62lA46w-X3JlkaMmorTpOZ6viZsy4Q0-b8UNmwt5b5-SBcWCrlSl_6uOIe/pubchart?oid=951480556&format=interactive",
  sheets_gid="1897009688",
  sql_file="fugu.sql"
  )
}}

Usage comparison of the Compression Streams API from 2024 and 2025 on desktop and mobile.

Adoption of the Compression Streams API grew sharply between 2024 and 2025, becoming the most widely used API in 2025 and overtaking Clipboard, which had been in the lead for three years.

On mobile, usage jumped from 2.34% to 12.33%, and on desktop from 2.69% to 13.97%. This steep rise aligns with the API becoming [widely supported across all major engines](https://web.dev/blog/compressionstreams) in the last two years, removing a technical blocker and letting developers drop JavaScript polyfills and rely on native gzip/deflate compression.

The API is particularly appealing for data-heavy applications where streaming efficiency matters, which explains its strong adoption curve.

### Clipboard API

The [Clipboard API](https://developer.mozilla.org/docs/Web/API/Clipboard_API) provides asynchronous read and write access to the system clipboard. It supports plain text, HTML, images, and other formats, though support may vary across browsers.

[Security restrictions](https://developer.mozilla.org/docs/Web/API/Clipboard_API#security_considerations) require clipboard operations to be triggered by a user gesture (like a click).

```js
// Write text

await navigator.clipboard.writeText("Hello from Web Almanac!");

// Read text
const text = await navigator.clipboard.readText();

console.log(text); // "Hello from Web Almanac!"
```

Supported in Chromium-based browsers and Safari. Firefox has partial support.

{{ figure_markup(
  image="clipboard.png",
  caption="Clipboard API usage.",
  description="Bar chart showing the growth in Clipboard API usage across mobile and desktop platforms between 2024 and 2025. On mobile devices, the percentage of pages using the API rose from 10.0% to 11.2%, while desktop usage saw a similar increase from 10.4% to 11.8%. Overall, the data shows a consistent upward trend in adoption for both platforms, with desktop maintaining a slightly higher overall usage rate than mobile in both years.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vSyxDgchtyy-8NISa8hPX62lA46w-X3JlkaMmorTpOZ6viZsy4Q0-b8UNmwt5b5-SBcWCrlSl_6uOIe/pubchart?oid=714385047&format=interactive",
  sheets_gid="1966659557",
  sql_file="fugu.sql"
  )
}}

Usage comparison of the Clipboard API from 2024 and 2025 on desktop and mobile.

The Clipboard API continues to see steady growth. Mobile adoption increased from 10.00% in 2024 to 11.19% in 2025, while desktop rose from 10.42% to 11.75%. This reflects developers increasingly moving away from legacy `execCommand()` clipboard hacks and embracing the async API for copy buttons and paste workflows. The year-over-year growth is moderate, underscoring that the Clipboard API is now a well-established utility rather than an emerging capability.

### Web Share API

The [Web Share API](https://developer.mozilla.org/docs/Web/API/Web_Share_API) allows web apps to invoke the device's native sharing mechanism, enabling users to share text, URLs, and files with other installed apps (e.g., messaging, email, or social apps).

The main method is `navigator.share()`, which takes an object with the data to share. The optional `navigator.canShare()` method can be used to check whether the provided data (especially files) is shareable before attempting.

The API requires a user gesture (such as a click) and will trigger the platform's share sheet, letting the user select the app to share with.

```js
const data = {
  title: "Web Almanac 2025",
  text: "Check out the latest edition of the Web Almanac!",
  url: "https://almanac.httparchive.org/en/2025/",
};

if (navigator.canShare && navigator.canShare(data)) {
  try {
    await navigator.share(data);
    console.log("Data shared successfully!");
  } catch (err) {
    console.error("Share failed:", err);
  }
} else {
  console.warn("Sharing not supported on this device.");
}
```

Supported in modern Chrome, Edge, and Safari. Firefox does not implement it.

{{ figure_markup(
  image="web-share.png",
  caption="Web Share API usage.",
  description="Bar chart showing a modest increase in Web Share API usage across both mobile and desktop platforms from 2024 to 2025. Mobile usage grew from 6.0% to 6.6%, while desktop usage saw a similar marginal rise from 6.2% to 6.7%.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vSyxDgchtyy-8NISa8hPX62lA46w-X3JlkaMmorTpOZ6viZsy4Q0-b8UNmwt5b5-SBcWCrlSl_6uOIe/pubchart?oid=1903144577&format=interactive",
  sheets_gid="930326182",
  sql_file="fugu.sql"
  )
}}

Usage comparison of the Web Share API from 2024 and 2025 on desktop and mobile.

There have been minor adjustments to the usage of one of the most widely adopted APIs, which currently occupies third place in the ranking of most used APIs.

Adoption of the Web Share API remained largely stable, with mobile rising slightly from 5.97% in 2024 to 6.55% in 2025, and desktop from 6.15% to 6.68%. Flat adoption, but with a slight uptick. This API has now reached a state of maturity and stability across major browsers; these incremental gains are indicative of natural fluctuations rather than significant growth.

### Device Memory API

The [Device Memory API](https://developer.mozilla.org/docs/Web/API/Device_Memory_API) exposes an approximation of the device's RAM, in gigabytes, through `navigator.deviceMemory`. This enables developers to tailor experiences (e.g., serving lighter pages to low-memory devices).

The value is rounded and coarse-grained for privacy reasons.

```js
console.log(navigator.deviceMemory);
// Example output: 8 (for an 8 GB device)
```

Available in Chromium-based browsers; not supported in Safari or Firefox.

{{ figure_markup(
  image="device-memory.png",
  caption="Device Memory API usage.",
  description="Bar chart showing a growth in Device Memory API usage for both mobile and desktop platforms. Mobile usage increased from 5.0% in 2024 to 6.3% in 2025, while desktop usage grew from 4.9% to 6.2%.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vSyxDgchtyy-8NISa8hPX62lA46w-X3JlkaMmorTpOZ6viZsy4Q0-b8UNmwt5b5-SBcWCrlSl_6uOIe/pubchart?oid=799153560&format=interactive",
  sheets_gid="1811570014",
  sql_file="fugu.sql"
  )
}}

Usage comparison of the Device Memory API from 2024 and 2025 on desktop and mobile.

The Device Memory API saw a noticeable uptick, moving from 5.05% to 6.27% on mobile and 4.88% to 6.21% on desktop. This increase reflects broader recognition of the API's usefulness for adaptive performance strategies, where developers can serve lighter assets to low-memory devices.

More developers are leveraging `navigator.deviceMemory` to deliver lighter experiences on low-memory devices. While adoption is still limited by its Chromium-only availability and its intentionally coarse-grained values, the growth shows that sites concerned with performance are starting to make practical use of it.

### Media Session API

The [Media Session API](https://developer.mozilla.org/docs/Web/API/Media_Session_API) lets developers customize media notifications and integrate with platform-level media controls (e.g., lock screen, headset buttons, or smart displays).

Using `navigator.mediaSession`, apps can define metadata and actions for media playback.

```js
navigator.mediaSession.metadata = new MediaMetadata({
  title: "Web Almanac Podcast",
  artist: "HTTP Archive",
  album: "2025 Edition",
});

navigator.mediaSession.setActionHandler("play", () => {
  audio.play();
});
```

Widely supported in Chromium-based browsers and Safari. Firefox has no support for some important features.

{{ figure_markup(
  image="media-session.png",
  caption="Media Session API usage.",
  description="This bar chart shows the usage of the Media Session API, which uniquely shows a slight downward trend across both platforms. Mobile usage decreased from 4.9% in 2024 to 4.7% in 2025, while desktop adoption also dipped from 5.5% to 5.3%.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vSyxDgchtyy-8NISa8hPX62lA46w-X3JlkaMmorTpOZ6viZsy4Q0-b8UNmwt5b5-SBcWCrlSl_6uOIe/pubchart?oid=1577112625&format=interactive",
  sheets_gid="1863050303",
  sql_file="fugu.sql"
  )
}}

Usage comparison of the Media Session API from 2024 and 2025 on desktop and mobile.

The Media Session API experienced a small decline. Mobile adoption dropped from 4.91% in 2024 to 4.65% in 2025, while desktop fell slightly from 5.46% to 5.29%. These differences are minor and likely reflect natural fluctuations in the dataset rather than meaningful shifts. Overall, usage remains steady, concentrated in audio and video sites like music players and podcast apps where integration with platform-level media controls improves user experience.

### Add to Home Screen

This capability allows users to install a Progressive Web App (PWA) on their device's home screen.

This is triggered when the browser fires the `beforeinstallprompt` event, typically after the PWA meets installability criteria (manifest, HTTPS, service worker).

{{ figure_markup(
  image="add-to-home-screen.png",
  caption="Add to Home Screen usage.",
  description="Bar chart showing a slight decline in Add to Home Screen usage across both mobile and desktop platforms. Mobile usage decreased from 4.8% in 2024 to 4.6% in 2025, while desktop adoption also saw a minor drop from 5.1% to 4.9%.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vSyxDgchtyy-8NISa8hPX62lA46w-X3JlkaMmorTpOZ6viZsy4Q0-b8UNmwt5b5-SBcWCrlSl_6uOIe/pubchart?oid=398812036&format=interactive",
  sheets_gid="1084353718",
  sql_file="fugu.sql"
  )
}}

Usage comparison of the Add to Home Screen from 2024 and 2025 on desktop and mobile.

Adoption of Add to Home Screen capabilities remained flat, with mobile usage decreasing slightly from 4.78% in 2024 to 4.59% in 2025, and desktop from 5.12% to 4.92%. These small declines likely reflect normal variation rather than a real downward trend. Growth is constrained by platform fragmentation: Android and Chromium-based browsers expose install prompts, while iOS lacks `beforeinstallprompt` and relies on a manual Safari-driven install flow. This limits widespread uptake despite PWA adoption.

### Media Capabilities API

The [Media Capabilities API](https://developer.mozilla.org/docs/Web/API/Media_Capabilities_API) allows developers to query whether the browser can efficiently decode and play a given audio or video configuration.

It provides insights into smoothness and power efficiency for adaptive media streaming.

```js
const config = {
  type: "file",
  audio: {
      contentType: "audio/mp3",
      channels: 2,
      bitrate: 132700,
      samplerate: 5200,
  },
};

const result = await navigator.mediaCapabilities.decodingInfo(config);

console.log(result.supported); // true or false
console.log(result.powerEfficient); // true or false
```

Widely available, it works across many devices and browser versions. It's been available across browsers since January 2020. But still some parts of this feature may have varying levels of support in browsers like Safari.

{{ figure_markup(
  image="media-capabilities.png",
  caption="Media Capabilities API usage.",
  description="Bar chart showing a surge in Media Capabilities API usage. Mobile adoption skyrocketed from a negligible 0.6% to 4.4%, while desktop usage saw an even larger jump from 0.8% to 5.0%.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vSyxDgchtyy-8NISa8hPX62lA46w-X3JlkaMmorTpOZ6viZsy4Q0-b8UNmwt5b5-SBcWCrlSl_6uOIe/pubchart?oid=1359620848&format=interactive",
  sheets_gid="1154224831",
  sql_file="fugu.sql"
  )
}}

Usage comparison of the Media Capabilities API from 2024 and 2025 on desktop and mobile.

The Media Capabilities API saw dramatic growth over the past year. Mobile adoption rose from just 0.61% in 2024 to 4.37% in 2025, while desktop usage jumped from 0.75% to 5.00%. This surge suggests rapid adoption by streaming platforms, which use `decodingInfo()` to determine codec support, playback smoothness, and power efficiency before selecting the best stream for a device. Unlike many of the other APIs that saw only incremental shifts, Media Capabilities is clearly on a fast adoption trajectory driven by media-heavy sites.

## New features over the past year

{# TODO: Add #}

### Built-in AI APIs

{# TODO: Add #}

## Conclusion

{# TODO: Add #}
