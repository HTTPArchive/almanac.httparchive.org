---
#See https://github.com/HTTPArchive/almanac.httparchive.org/wiki/Authors'-Guide#metadata-to-add-at-the-top-of-your-chapters
title: Resource Hints
description: Resource Hints cahpter of the 2021 Web Almanac covering adoption of resource hints, their uses, bad practices and their impact on performance.
authors: [kevinfarrugia]
reviewers: [siakaramalegos, tunetheweb, samarpanda]
analysts: [nithanaroy]
editors: [rviscomi]
translators: []
results: https://docs.google.com/spreadsheets/d/1Mw6TjkIClRtlZPHbij5corOZbaSUp-vgTVq3Ig18IwQ/
kevinfarrugia_bio: Kevin Farrugia is a consultant on web performance and software architecture. You can find him on <a hreflang="en" href="https://imkev.dev">imkev.dev</a>.
featured_quote: Resource hints could become a double-edged sword if the benefit for your users is not evaluated. A quarter of preload requests went unused while the number of preload hits correlated with slower load times.
featured_stat_1: 44.28%
featured_stat_label_1: Adoption of preload in the top 1,000 websites.
featured_stat_2: 21.48%
featured_stat_label_2: Unused preload hints within the first 3 seconds.
featured_stat_3: 60%
featured_stat_label_3: Lazy loaded images within the initial viewport.
---

## Introduction

Resource Hints are instructions to the browser that you may use to improve a website's performance. This set of instructions enables you to assist the browser in prioritizing origins or resources which need to be fetched and processed.

Let's take a closer look at how resource hints are implemented, what are the most common pitfalls and what we can do to make sure we are using resource hints as effectively as possible. 

### The Link directive

The most widely adopted resource hints are implemented through the Link directive's rel attribute. These are <a hreflang="en" href="https://www.w3.org/TR/resource-hints/#dfn-dns-prefetch">`dns-prefetch`</a>, <a hreflang="en" href="https://www.w3.org/TR/resource-hints/#dfn-preconnect">`preconnect`</a>, <a hreflang="en" href="https://www.w3.org/TR/resource-hints/#dfn-prefetch">`prefetch`</a>, <a hreflang="en" href="https://www.w3.org/TR/resource-hints/#dfn-prerender">`prerender`</a> and <a hreflang="en" href="https://www.w3.org/TR/preload/">`preload`</a>.

These may implemented in one of three ways:

**HTML Element**

```
<linkrel="dns-prefetch" href="https://example.com" /\>
```

**HTTP Header**

```
Link: <https://example.com\>; rel=dns-prefetch
```

**JavaScript**

```
const link = document.createElement("link");
link.rel="prefetch";
link.href="https://example.com";

document.head.appendChild(link);
```

![](https://lh6.googleusercontent.com/4YQ2F-Rry32FC_b2pOXRqQMakNDe0zd6wlAHceUm2qr4WJXg9icI9uMD4M-WwheFZDxWIN60HalLKtVcFCm026OGl0IeQ1qzN6u_xwDCEkbeOg_9JFiCGVOeUcq99Ou9S1hne6Il)

Adoption for HTTP Headers is significantly lower than having resource hints implemented as part of the document markup; with less than 1.5% of the pages analyzed implementing resource hints through HTTP Headers. This is likely attributed to the ease with which they may be added or modified from within the HTML source, when compared to adding an HTTP header on the server.

Using our current methodology, it is not possible to reliably measure resource hints which are added following user-interaction, such as <a hreflang="en" href="https://github.com/GoogleChromeLabs/quicklink">QuickLink</a>, which featured on less than 0.1% of pages analyzed.

Considering that the adoption of resource hints using HTTP Headers is markedly smaller than adoption for `<link rel\>`, the rest of this chapter will focus on analyzing the usage of resource hints through the HTML Element unless otherwise specified.

#### Types of Resource Hints

##### dns-prefetch

The `dns-prefetch` link initiates an early request to resolve a domain name. It is only effective for DNS lookups on cross-origin domains and may be paired together with `preconnect`. While Chrome now supports a maximum of <a hreflang="en" href="https://source.chromium.org/chromium/chromium/src/+/fdf9418d23d434e0f7134da67dc41b0fe8268e91:net/dns/host_resolver_manager.cc;l=416">64</a> concurrent in-flight DNS requests - up from 6 last year - other browsers still have tighter limitations. For example it is limited to <a hreflang="en" href="https://github.com/mozilla/gecko-dev/blob/master/netwerk/dns/nsHostResolver.h#L48">8</a> on Firefox.

```
<link rel="dns-prefetch" href="https://example.com/"\>
```

##### preconnect

The `preconnect` link behaves similarly to `dns-prefetch`, but in addition to DNS lookups, it also establishes a connection together with TLS handshake if served over HTTPS. You are able to use `preconnect` in place of `dns-prefetch` as it gives a greater performance boost; but you must use it sparingly as each certificate weighs at least 3KB, which would be competing with bandwidth for other resources. You also want to avoid wasting CPU time opening connections which aren't required for critical resource. Keep in mind that if a connection isn't used within a short period of time (e.g. 10 seconds on Chrome), it would automatically be closed by the browser.

```
<link rel="preconnect" href="https://example.com/"\>
```

##### prefetch

The `prefetch` link allows you to recommend to the browser that a resource might be required by the next navigation. The browser may initiate a low-priority request for the resource, possibly improving the user experience as it would be fetched from the cache when needed. The resource would not be preprocessed or executed until the user navigates to the page which requires the resource.

```
<link rel="prefetch" href="/library.js" as="script"\>
```

##### prerender

The `prerender` link allows you render a page in the background, improving its load time if the user navigates to it. In addition to requesting the resource, the browser may also preprocess and fetch and execute subresources. `prerender` could end up wasteful if the user does not navigate to the prerendered page. To reduce this risk, Chrome treats the `prerender` hint as a NoState Prefetch. Unlike a full prerender it won't execute JavaScript or render any part of the page in advance.

```
<link rel="prerender" href="//example.com/page-2/"\>
```

##### preload

Most modern browsers also <a hreflang="en" href="https://caniuse.com/link-rel-preload">support</a> the `preload` hint - and to a <a hreflang="en" href="https://caniuse.com/link-rel-modulepreload">lesser degree</a>, the <a hreflang="en" href="https://html.spec.whatwg.org/multipage/links.html#link-type-modulepreload">`modulepreload`</a> hint. The `preload` instruction initiates an early fetch for a resource which is required in the loading of a page and is most commonly used for late-discovered resources, such as font files or images referenced in stylesheets. Preloading a resource may also be used to elevate its priority, allowing the developer to prioritize the loading of an LCP (<a hreflang="en" href="https://web.dev/lcp">Largest Contentful Paint</a>) image, even if this would otherwise be discovered while parsing the HTML.

`modulepreload` is a specialized alternative to `preload` and behaves similarly, however its usage is limited to <a hreflang="en" href="https://html.spec.whatwg.org/multipage/webappapis.html#module-script">module scripts</a>.

## Adoption & Trends

![](https://lh6.googleusercontent.com/L8MXZ46-pZd1UbHFOloEtPhfhMe-WNnGkiGm6jYzmAz8a0RQk6E7WZ1CW2lr2LDrv31q9i2mreYzp-KtsLMv5Uo8nVnsnsIpy_bNvr3j8SWFSNl7XDtJLCEYXPAc-3yMyR9NQAVa)

The most widely used resource hint is `dns-prefetch` (36.43% on mobile) - which is unsurprising, considering it was introduced in <a hreflang="en" href="https://caniuse.com/link-rel-dns-prefetch">2009</a> - however with the widespread use of HTTPS, in many cases it should be replaced with `preconnect` (12.72% on mobile). When considering that the `preload` hint is comparatively new - first appearing in Chrome in <a hreflang="en" href="https://groups.google.com/a/chromium.org/g/blink-dev/c/_nu6HlbNQfo/m/XzaLNb1bBgAJ?pli=1">2016</a>, it is the second most widely adopted resource hint (22.10% on mobile) and is seeing constant growth year-on-year - a testament to the importance and flexibility of this directive.

As shown in the charts above, the adoption rates on mobile and desktop are near-identical.

![](https://lh4.googleusercontent.com/R-mO_NPvAe52Im0NfJA7Q3SwoVHsOSWtx9iW4Rw06-wtKixPrwOdAfzv7Fh7p_2UPdW-EvPlIpdOd2kkpTcxzsvx80gnrw0XIOAmWv-FKtzpdfGvKJppCvYmM-1dcCLCX2yJqD-I)

### By Rank

![](https://lh4.googleusercontent.com/jOhFDxZPSOUfd5aftoHZA4_ylV8sRJSWENuInNps_bxoKTgREi-WZFLBixkmWymFxJUeL-vhTw9GQzMHiLtCFzD4726rnD5B7iQ9cChfPgArHGgq32l0_fkm6ZqsUZOOXMKAnL_9)

You can observe that when segmenting the data by [rank](./methodology#chrome-ux-report), the adoption rates change notably, with the `preload` hint increasing from 22.10% unranked, to claim the top spot with an adoption rate of 44.28% amongst the top 1,000 sites.

![](https://lh4.googleusercontent.com/phTk_mFr9nPDX_Ps7nTbepfiVwvCKsxJl6rKBN6odV3hSfeQqmY30DG6KNsPyoEWkvFXCYVTGTzWFeHESgJO0V_QnRBHWpm44cds-28ksBQpBkHMKkK63ybVKSk_2He8wZITT9-j)

`dns-prefetch` is the only resource hint which exhibits a decrease in adoption when comparing the top 1,000 sites with the overall adoption.

![](https://lh5.googleusercontent.com/3Nebgh6w8WZt7e4HPWV6DFnNdRW9wn7yBmBZFvqcZ7gb7PrDE1Z85u-nd1mCuOihkYQvD2sxOFC-P6Pld0dmv6TIUuHXMXaTqXoEZJK7C3AsZ8LdpK2P_RSQn2wudfVSUqNVE-G3)

To counter this decrease, the top 1,000 pages have an increased adoption for the `preconnect` hint taking advantage of the benefits covered earlier on in the chapter.

### Usage

Resource hints can be very effective if used correctly. By shifting the responsibility from the browser to the developer, it allows you to prioritise resources required for the critical rendering path and improve the load times & user experience.

**Median number of hints by rank**

// TODO: table

Of the sites using resource hints, when comparing top 1000 ranking sites to the entire corpus, the top ranking sites have more resource hints per page (median). The only hint which observes a different pattern is `prerender`; which has a total of 0 occurrences in the top 1000 sites.

### Correlation with Core Web Vitals

![](https://lh6.googleusercontent.com/XOvE8eYW63LWKA02RleWESmixnumsNV3ZIdvkqM0ernplzjtqpxS-UW08bee0HJFEeh6oUdpsTHcIs4voWHTex_5YYRt6FlI_zqoOoyQ9SaPFqmJpNTkvYr03x-68lmsNpgBTGNV)B

By combining a page's <a hreflang="en" href="https://web.dev/cwv">Core Web Vitals</a> scores in the CrUX dataset and the usage of the preload resource hint, you can observe a negative correlation between the number of link elements and the percentage of pages which score a good rating on CWV - the pages which use fewer preload hints are more likely to have a good rating.

![](https://lh5.googleusercontent.com/yKUu9S8hBmWt-iimjSCx1W80uS1tGsKNUGj9ZlbK5JW6GvldlOkMsKJ_sQZHaKNXiiK99KP1LbD4_8EIN1mtHADMJwnJ6_Sms--4Q8g8-Yn8-EoNBFeu8h-NY9QM_skWyNu2YMgp)

This same observation may be seen on a page's <a hreflang="en" href="https://web.dev/lcp">Largest Contentful Paint</a> and <a hreflang="en" href="https://web.dev/fcp">First Contentful Paint</a>, indicating that in many cases, the developer is prioritizing resources which aren't needed to render the LCP element and as a consequence degrading the user experience.

While this doesn't prove that having preload hints causes a page to get slower, having many does coincide with having slower performance. Every page has its own unique requirements and it is impossible to apply a "one size fits all" approach, but in the majority of cases the number of preloaded resources should be kept low and resource prioritization should be delegated to the browser when possible.

<p class="note">Note: In addition to the number of hints, the size of each preloaded resource has an impact on the website performance. The above figure does not take into consideration the size of each preloaded resource.</p>

### `rel="preload"`

With that being said, and the expectation that more websites will adopt `preload`, let's take a better look at the preload resource hint and understand why it is so effective, yet at the same time so prone to misuse.

#### The `as` attribute

The `as` attribute should be specified when using `rel="preload"` (or rel="prefetch") to specify the type of resource being downloaded. Applying the correct `as` attribute allows the browser to prioritize the resource more accurately, improve caching for future requests and apply the correct <a hreflang="en" href="https://developer.mozilla.org/en-US/docs/Web/HTTP/CSP">content-security policy</a>.

![](https://lh4.googleusercontent.com/SA8emNGNyq9WN0YQbaxBzDG24ckC77eH6TyrAzX3VNLbRUYmwHEZMpIVMxUVa8yl_6P-p8Sn5Ka8QUyAe0BzhICb7dHSL5JZdAgPHo3jO3sbgcIUpn-v-yySPYZW_DBuDe6pN52a)

**script**: `script` is the most common value by a significant margin. `<script>` elements are usually discovered early as they are embedded in the initial HTML document, but it is a common practice to place `<script>` elements before the closing `<body>` tag. Since HTML is parsed sequentially, this means that the scripts will be discovered after the DOM is downloaded and parsed - and with more websites dependent on JavaScript frameworks, the necessity to have JavaScript load early has increased. The downside is that JavaScript resources would be prioritized over the other resources discovered within the HTML document, including images and stylesheets, possibly compromising the user experience.

**font**: The second most commonly preloaded resource is the `font`, which is a late-discovered resource since the browser will only download a font file after the layout phase when the browser knows that the font will be rendered on the page.

**style**: Stylesheets are ordinarily embedded in the document's `<head>` and discovered early during the document parsing. Additionally, as stylesheets are render-blocking resources they are assigned the _Highest_ request priority. This should make preloading stylesheets unnecessary but it is sometimes required to re-prioritize the requests. A <a hreflang="en" href="https://bugs.chromium.org/p/chromium/issues/detail?id=629420">bug</a> in Google Chrome (fixed in Chrome 95) prioritizes preloaded resources ahead of other higher-priority resources discovered by the preload scanner, including CSS files. Preloading the stylesheet will restore its _Highest_ priority. Another instance when stylesheets are preloaded is when they are not downloaded directly from the HTML document, such as the <a hreflang="en" href="https://www.filamentgroup.com/lab/async-css.html">asynchronous CSS</a> "hack" which uses an `onload` event to avoid render-blocking the page with non-critical CSS.

**fetch**: Preload may also be used to initiate a request to retrieve data which you know is critical to the rendering of the page, such as a JSON response or stream.

#### The `crossorigin` attribute

The `crossorigin` attribute is used to indicate whether CORS must be used when fetching the requested resource. This could apply to any resource type, but it is most commonly associated with font files as they should always be requested using CORS.

// TODO: Table

**anonymous**: The default value when no value is specified, `anonymous` will set the credentials flag to <a hreflang="en" href="https://developer.mozilla.org/en-US/docs/Web/Security/Same-origin_policy">`same-origin`</a> and is required when downloading resources protected by CORS. It is also a <a hreflang="en" href="https://drafts.csswg.org/css-fonts/#font-fetching-requirements">requirement</a> when downloading font files - even if they are on the same origin! If you omit the `crossorigin` attribute when the eventual request for the preloaded resource uses CORS, you will end up with a duplicate request since it won't match in the preload cache.

**use-credentials**: When requesting cross-origin resources which require authentication, for example through the use of cookies, client certificates or the `Authorization` header; setting the `crossorigin="use-credentials"` attribute will include this data in the request and allowing the server to respond to the request so that the resource may be preloaded. This is not a common scenario with 0.04% usage, however if your page content is dependent on an authenticated status, it could be used to initiate an early fetch request to get the login status.

#### The `media` attribute

An oft neglected feature available to `rel="preload"`, is the ability to specify media queries through the `media` attribute - with less than 4% of all preloads using this attribute. The `media` attribute accepts media queries allowing you to target the media type and specific browser features, such as viewport width. As an example, the `media` attribute would allow you to preload a low-resolution image on devices with a narrow viewport and a full-sized image on devices with a large viewport.

In addition to the `media` attribute, the `<link>` element supports `imagesrcset` and `imagesizes` attributes which correspond to the `srcset` and `sizes` attributes on `<img>` elements. Using these attributes, you are able to use the same resource selection criteria that you would use on your image. Unfortunately their adoption is very low (less than 1%); most likely owing to the lack of <a hreflang="en" href="https://caniuse.com/mdn-html_elements_link_imagesizes">support</a> on Safari.

<p class="note">Note: The `media` attribute is not available on all `<link>` elements as the spec suggests, but it is only available on `rel="preload"`.</p>

### Bad practices

Owing to the versatility of `rel="preload"`, there isn't a clear set of rules dictating how to implement the preload hint, but we are able to learn a lot from our mistakes and understand how to avoid them.

#### Unused preload

We have already seen that there is a negative correlation between a website's performance and the number of preload hints. This relationship may be influenced by two factors:

**Incorrect preloads**: When you preload a resource which is not as important as the other resources which the browser would have otherwise prioritized. We are unable to measure the extent of incorrect preloads as you would need to A/B test the page with and without each hint.

**Unused preloads**: When you preload a resource which is not needed within the first few seconds of the page loading.

// TODO: 21.48% of preload hints are unused within the first 3 seconds

In such cases, the preload hint is regressing the website's performance, as you are instructing the browser to download and prioritize files or resources which are not needed immediately - or even not needed at all. This is one of the challenges when using resource hints, as they require regular maintenance and automating the process opens the door to allow such issues to creep in.

// TODO: 389 The most unused `rel="preload"` on a single page

#### Incorrect `crossorigin` attribute

Attempting to preload a CORS-enabled resource without including the correct `crossorigin` attribute will download the same resource twice. The `crossorigin` attribute is required on the `<link>` element if the eventual request would also use CORS. This is also the case when requesting font files, even when self-hosting font files on the same origin, as font files are always treated as CORS-enabled.

![](https://lh6.googleusercontent.com/Tbs1hLdDacIKI4TyMzSzyZbUnLv_9EQN9sa2EHp9xnhz293wy649o6Ek9iFCvr0jF8yJcJ5_jTHEWTmZEzv_mn2assZJqIybk1Q21vEaZkdXR0UmyxIH4JhsxWOvS0vmHhreUD52)

More than half of the cases when the `crossorigin` attribute on the `rel="preload"` hint is either missing or incorrect are linked to the preloading of font files, with a total of 14,818 instances across the dataset.

#### Invalid `as` attribute

The `as` attribute plays an important role when preloading your resources and getting this wrong may also result in downloading the same resource twice. On most browsers, specifying an unrecognized `as` attribute will ignore the preload. The supported values are `audio`, `document`, `embed`, `fetch`, `font`, `image`, `object`, `script`, `style`, `track`, `worker` and `video`. 

There are 17,861 cases of unrecognised values, with the most frequent error being omitting it completely; while the most common invalid as values are `other` and `stylesheet` (the correct value is `style`).

// TODO: 1114 pages incorrectly used `stylesheet` instead of `style`

When using an incorrect `as` attribute value - as opposed to unrecognised value, such as using `style` instead of `script`; the browser will duplicate the file download as the request won't match the resource stored in the preload cache.

<p class="note">Note: While `video` is included in the spec, it isn't supported by any browser and would be treated as an invalid value and ignored.</p>

#### Unused font files

More than 5% of pages which preload font files, preload more font files than needed. When preloading font files, all browsers which support `preload` also support `.woff2`. This means that, assuming that the `.woff2` font files are available, it is not necessary to preload older formats, including `.woff`.

### Third Parties

You are able to use resource hints to connect to or download resources from both first and [third parties](./third-parties). While `dns-prefetch` and `preconnect` are only useful when connecting to different origins, including subdomains; `preload` and `prefetch` may be used for both resources on the same origin and resources hosted by third parties.

When considering which resource hints you should use for third party resources, you need to evaluate the priority and role of each third party on your application's loading experience and whether the costs are justified. 

Prioritising third party resources over your own content is potentially a warning sign, however there are cases when this is recommended. As an example, if we look at cookie notice scripts; which are required in the European Union by General Data Protection Regulation; these are usually accompanied by a `dns-prefetch` or `preconnect` script as they are highly obtrusive to the user experience and also a prerequisite for some site functions, such as serving personalised ads.

**Third parties connected to using resource hints**

// TODO: table

Analysing the table above, 42.72% of all pages which include a `preload` hint are preloading resources hosted on adservice.google.com, while s.w.org (WordPress) is the most popular domain for `dns-prefetch` and `fonts.gstatic.com` for the `preconnect` directive.

<p class="note">Note: Google Fonts now includes instructions to `preconnect` to both the fonts.gstatic.com origin and fonts.googleapis.com.</p>

### Native Lazy Loading

Native image and iframe lazy-loading have been standardized in 2019 and since then, their adoption - especially for images - has grown exponentially. Lazy-loading refers to the technique to defer downloading a resource - in this case an image or iframe - until it is needed or visible within the viewport.

`loading="lazy"` on images is supported on most major browsers. On Safari, it is marked as <a hreflang="en" href="https://bugs.webkit.org/show_bug.cgi?id=200764">in progress</a> and is available behind a flag, but not yet enabled by default. Lazy-loading of iframes has similar support, although it is <a hreflang="en" href="https://bugzilla.mozilla.org/show_bug.cgi?id=1622090">not yet supported on Firefox</a>.

Browsers which do not support the loading attribute, will simply ignore it - making it safe to add without unwanted side-effects. JavaScript based alternatives, such as <a hreflang="en" href="https://github.com/aFarkas/lazysizes">lazysizes</a> may still be used, however considering that full browser support is around the corner, it may not be worth adding to a project at this stage.

![](https://lh5.googleusercontent.com/fUgZHiwFaCNN209PcAllIohazj6Clf8y3fd8Shx_l3AKnicRd3QM1oD-Au1pbWaRC7D3ZUbuHF06W8amsiVNxenyjxI5c4vk8CzkY-3C83uuX9hY9xsfgNMTYS5sAl0tWwWGpMRp)

The number of pages using `loading="lazy"` has grown from 4.17% in 2020 to 18.28% in 2021. This rapid growth is extraordinary and is likely driven by two key elements. The ease with which it could be added to pages without cross-browser compatibility issues, and the frameworks or technologies powering these websites. In WordPress 5.5, <a hreflang="en" href="https://make.wordpress.org/core/2020/07/14/lazy-loading-images-in-5-5/">lazy-loading images became the default implementation</a>, supercharging the adoption rate of `loading="lazy"`, with WordPress sites now making up <a hreflang="en" href="https://web.dev/lcp-lazy-loading/">84%</a> of all pages which use native image lazy-loading.

An <a hreflang="en" href="https://web.dev/lcp-lazy-loading/">analysis</a> of the load times for pages which use lazy-loading indicated that pages which use lazy-loading tend to have a worse LCP performance, possibly caused by overusing the lazy-loading attribute on the LCP element which shouldn't be lazy-loaded. If you are using `loading="lazy"`, you should check that the lazily-loaded images are below the fold and more critically, that the [LCP element is not lazy-loaded](./performance). More than 60% of all images which are lazy-load are actually within the initial viewport and shouldn't be lazy-loaded.)

![](https://lh6.googleusercontent.com/ilEMPIT4mHlOaQGOyLntcaHwp6A7qlyec_BsxuXbUtP6QU5WMYnWQe1-i958s-g49EfEfdD9QdfEsFh4RQpFvtCBK50vacYpLB71Hud7g8dJoR5V-Quv3p8YBFTm3Ds8csI01NnH)

The likelihood of a page containing at least one iframe is much lower than for that containing an image with only 2.56% of pages containing an iframe taking advantage of native lazy-loading. The benefits of lazy-loading an iframe are potentially important, as an iframe could initiate further requests to download even more resources, including scripts and images. This is especially true when using embeds, such as YouTube or Twitter embeds. Similarly to when deciding the loading strategy for an image, you must check whether the iframe is shown within the initial viewport or not. If it isn't, then it is usually safe to add `loading="lazy"` to the `<iframe>` element to benefit from a reduced initial load & boost performance.

### HTTP/2 Server Push

HTTP/2 supports a technology called Server Push that preemptively pushes a resource it expects the client will be requesting. As the server is pushing the resource instead of informing the client that it should request it, cache-management becomes complex and in some cases the pushed resources would even delay the delivery of the HTML, which is critical for discovering all resources required to load the page.

Unfortunately HTTP/2 push has been disappointing with little evidence that it provides the performance boost promised, compared to the risk of over pushing resources that either the browser already has, or that are of less importance than resources the browser requests.

So while the technology is widely available, overcoming these obstacles makes it highly unpopular - with less than 1% adoption on Chrome. Chrome has also filed an <a hreflang="en" href="https://lists.w3.org/Archives/Public/ietf-http-wg/2019JulSep/0078.html">Intent to Remove</a> that is paused until a testable implementation of 103 Early Hints is available.

### Future

While there are no proposals to add new rel directives, improvements from the browser vendors to the current set of resource hints - such as the prioritization <a hreflang="en" href="https://bugs.chromium.org/p/chromium/issues/detail?id=629420">bug</a> in Chrome - are expected to have a positive impact. Hint adoption is expected to evolve and the use of `preload` should shift towards its intended purpose - late discovered resources.

Additionally, two new proposals, 103 Early Hints and Priority Hints are expected to be made available in the near future, with experimental support already available on Chrome.

#### 103 Early Hints

Chrome 95 added experimental support for <a hreflang="en" href="https://datatracker.ietf.org/doc/html/rfc8297">103 Early Hints</a> for `preload` and `preconnect`. Early hints enable the browser to preload resources before the main response is served and take advantage of the idle time on the browser between the request being sent and the response from the server. When using 103 Early Hints, the server immediately sends an "informational" response status detailing the resources to be preloaded and then returns to processing the request before sending the real document response. This way, the browser will be able to initiate preload requests for critical resources even before the time to first byte (TTFB) and much earlier than it would if using the `<link>` element in the document markup while overcoming most of the difficulties encountered with HTTP/2 Server Push.

#### Priority Hints

Priority hints inform the browser of the relative importance of resources within the page, with the goal of prioritising more important resources and improving Core Web Vitals. Priority Hints are enabled through the document markup by adding the `importance` attribute to resources, such as `<img>` or `<script>`. The `importance` attribute accepts an enumeration of `high`, `low` or `auto` and by combining this with the type of resource, the browser would be able to assign the optimal fetch priority based on its own heuristics. Priority Hints are available on Chrome 96 as an origin trial.

### Conclusion

During the past year, resource hint adoption grew and is expected to continue growing as developers take advantage of these APIs to prioritize resources and improve the user's experience. At the same time, browser vendors have continued calibrating these directives, evolving their role and effectiveness.

Resource hints could become a double-edged sword if the benefit for your users is not evaluated. Almost a quarter of preload requests went unused while the number of preload hits correlated with slower load times.

Resource hints are akin to fine tuning a race car's engine. They would not turn a slow engine into a fast one, and too many adjustments could break it. Yet, some small tweaks here and there would allow you to maximize it.

So once again, the mantra behind resource hints remains, "if everything is important, then nothing is". Use resource hints wisely and don't overuse them.