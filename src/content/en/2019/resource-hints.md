---
part_number: IV
chapter_number: 19
title: Resource Hints
description: Resource Hints chapter of the 2019 Web Almanac covering usage of dns-prefetch, preconnect, preload, and prefetch as well as priority hints and native lazy loading
authors: [khempenius]
reviewers: [andydavies, bazzadp, yoavweiss]
published: 2019-11-04T12:00:00+00:00:00
last_updated: 2019-11-07T21:25:05.000Z 
---

## Introduction

[Resource hints](https://www.w3.org/TR/resource-hints/) provide “hints” to the browser about what resources will be needed soon. The action that the browser takes as a result of receiving this hint will vary depending on the type of resource hint; different resource hints kick off different actions. When used correctly, they can improve page performance by giving a head start to important anticipated actions.

[Examples](https://youtu.be/YJGCZCaIZkQ?t=1956) of performance improvements as a result of resource hints include:

*   Jabong decreased Time to Interactive by 1.5s by preloading critical scripts.
*   Barefoot Wine decreased Time to Interactive of future pages by 2.7s by prefetching visible links. 
*   Chrome.com decreased latency by .7s by preconnecting to critical origins.

There are four separate resource hints supported by most browsers today: dns-prefetch, preconnect, preload, and prefetch.

###dns-prefetch

What it does: Initiates an early DNS lookup.

Useful for: Completing the DNS lookup for third-parties. For example, the DNS lookup of a CDN, font provider, or third-party API.

Read more: [dns-prefetch (MDN)](https://developer.mozilla.org/en-US/docs/Learn/Performance/dns-prefetch)

###preconnect

What it does: Initiates an early connection - including DNS lookup, TCP handshake, and TLS negotiation.

Useful for: Setting up a connection with third parties. The uses of preconnect are very similar to those of dns-prefetch - but preconnect has less browser support. However, if you don’t need IE 11 support, preconnect is probably a better choice.

Read more: [preconnect (web.dev)](https://web.dev/uses-rel-preconnect)

###preload

What it does: Initiates an early request.

Useful for: Loading important resources that would otherwise be discovered late by the parser. For example, if an important image is only discoverable once the browser has received and parsed the stylesheet, it may make sense to preload the image.

Read more: [Preload, prefetch, and priorities in Chrome](https://medium.com/reloading/preload-prefetch-and-priorities-in-chrome-776165961bbf)

###prefetch

What it does: Initiates a low-priority request.

Useful for: Loading resources that will be used on the subsequent (rather than current) page load. A common use of prefetch is loading resources that the application “predicts” will be used on the next page load. These predictions could be based on signals like user mouse movement or common user flows/journeys.

Read more: [All about prefetching (Performance Calendar)](https://calendar.perfplanet.com/2018/all-about-prefetching/)


## Syntax

97% of resource hint usage relied on using the [<link>](https://developer.mozilla.org/en-US/docs/Web/HTML/Element/link) tag to specify a resource hint. For example:
```html
<link rel="prefetch" href="shopping-cart.js">
```

Only 3% of resource hint usage used [HTTP headers](https://developer.mozilla.org/en-US/docs/Web/HTTP/Headers/Link) to specify resource hints. For example.
```
Link: <https://example.com/shopping-cart.js>; rel=prefetch
```

Because the usage of resource hints in HTTP headers is so low, the remainder of this chapter will focus solely on analyzing the usage of resource hints in conjunction with the <link> tag. However, it’s worth noting that in future years, usage of resource hints in HTTP headers may increase as HTTP/2 Push is adopted. This is due to the fact that HTTP/2 Push has repurposed the HTTP preload link header as a signal to push resources.


## Resource Hints

_Note: There was no noticeable difference between the usage patterns for resource hints on mobile versus desktop. Thus, for the sake of conciseness, this chapter only includes the statistics for mobile._

The relative popularity of dns-prefetch is unsurprising: it's a well-established API (it first appeared in [2009](https://caniuse.com/#feat=link-rel-dns-prefetch)), it is supported by all major browsers, and it is the most “inexpensive” of all resource hints. Because dns-prefetch only performs DNS lookups, it consumes very little data, and therefore there is very little downside to using it. dns-prefetch is most useful in high-latency situations.

That being said, if a site does not need to support IE11 and below, switching from dns-prefetch to preconnect is probably a good idea. In an era where HTTPS is ubiquitous, preconnect yields greater performance improvements while still being inexpensive. (Unlike dns-prefetch, preconnect not only initiates the DNS lookup, but also the TCP handshake and TLS negotiation. The [certificate chain](https://knowledge.digicert.com/solution/SO16297.html) is downloaded during TLS negotiation - this typically costs a couple kilobytes.) 

According to the data set, prefetch is used by 3% of sites, making it the least widely used resource hint. This low usage may be explained by the fact that prefetch is useful for improving subsequent rather than current page loads. Thus, it will be overlooked if a site is only focused on improving their landing page or the performance of the first page viewed. In addition, the way prefetch is used may lead to its usage to be very slightly under-reported. This data set was collected by querying the DOM at runtime: it includes dynamically injected resource hints, but it would not include, for example, resource hints that are dynamically injected as a result of a user action.


<table>
  <tr>
   <td><strong>Resource Hint</strong>
   </td>
   <td><strong>Usage (% of sites)</strong>
   </td>
  </tr>
  <tr>
   <td>dns-prefetch
   </td>
   <td>29%
   </td>
  </tr>
  <tr>
   <td>preload
   </td>
   <td>16%
   </td>
  </tr>
  <tr>
   <td>preconnect
   </td>
   <td>4%
   </td>
  </tr>
  <tr>
   <td>prefetch
   </td>
   <td>3%
   </td>
  </tr>
  <tr>
   <td>prerender (deprecated)
   </td>
   <td>0.13%
   </td>
  </tr>
</table>


Resource hints are most effective when they’re used selectively (“when everything is important, nothing is”). The table below shows the number of resource hints per page for pages using at least one resource hint. Although there is no clear cut rule for defining what an appropriate number of resource hints is, it appears that most sites are using resource hints appropriately.


<table>
  <tr>
   <td><strong>Resource Hint</strong>
   </td>
   <td><strong>Resource Hints Per Page:<br>Median</strong>
   </td>
   <td><strong>Resource Hints Per Page:<br>90th Percentile</strong>
   </td>
  </tr>
  <tr>
   <td>dns-prefetch
   </td>
   <td>2
   </td>
   <td>8
   </td>
  </tr>
  <tr>
   <td>preload
   </td>
   <td>2
   </td>
   <td>4
   </td>
  </tr>
  <tr>
   <td>preconnect
   </td>
   <td>2
   </td>
   <td>8
   </td>
  </tr>
  <tr>
   <td>prefetch
   </td>
   <td>1
   </td>
   <td>3
   </td>
  </tr>
  <tr>
   <td>prerender (deprecated)
   </td>
   <td>1
   </td>
   <td>1
   </td>
  </tr>
</table>

## The `crossorigin` Attribute

Most “traditional” resources fetched on the web: images, stylesheets and scripts are fetched without opting in to CORS. That means that if those resources are fetched from a cross-origin server, by default their contents cannot be read back by the page, due to the same-origin policy.

In some cases, the page can opt-in to fetch the resource using [CORS](https://developer.mozilla.org/en-US/docs/Web/HTTP/CORS) (Cross-Origin Resource Sharing) if it needs to read its content. CORS enables the browser to “ask permission” and get access to those cross-origin resources.

For newer resource types (e.g. fonts, fetch() requests, ES modules), the browser default to requesting those resources using CORS, failing the requests entirely if the server does not grant it permission to access them.

In the context of resource hints, usage of the crossorigin attribute enables them to match the CORS mode of the resources they are supposed to match and indicates the credentials to include in the request. For example: `<link rel=”prefetch” href=”https://other-server.com/shopping-cart.css” crossorigin=”anonymous”>` enables CORS and indicates that no credentials should be included for those cross-origin requests.

Although other HTML elements support the crossorigin attribute, this analysis only looks at usage with resource hints.


<table>
  <tr>
   <td><strong>Value of <code>crossorigin</code> attribute</strong>
   </td>
   <td><strong>Usage (% of resource hint instances)</strong>
   </td>
   <td><strong>Explanation</strong>
   </td>
  </tr>
  <tr>
   <td>Not set
   </td>
   <td>92%
   </td>
   <td>If the crossorigin attribute is absent, the request will follow the single-origin policy.
   </td>
  </tr>
  <tr>
   <td>anonymous (or equivalent)
   </td>
   <td>7%
   </td>
   <td>Executes a cross-origin request that does not include credentials.
   </td>
  </tr>
  <tr>
   <td>use-credentials
   </td>
   <td>0.47%
   </td>
   <td>Executes a cross-origin request that includes credentials.
   </td>
  </tr>
</table>



## The `as` attribute

`as` is an attribute that should be used with the `preload` resource hint to inform the browser of the type (e.g. image, script, style, etc.) of the requested resource. This helps the browser correctly prioritize the request and apply the correct [Content Security Policy (CSP)](https://developers.google.com/web/fundamentals/security/csp). Content Security Policy is a security mechanism, expressed via HTTP header, that helps mitigate the impact of XSS and other malicious attacks by declaring a whitelist of trusted sources; only content from these sources can be rendered or executed.

88% of resource hint instances use the `as` attribute. When `as` is specified, it is overwhelmingly used for scripts:  92% of usage is script, 3% font, and 3% styles. This is unsurprising given the prominent role that scripts play in most sites’ architecture as well the high frequency with which scripts are used as attack vectors (thereby making it therefore particularly important that scripts get the correct CSP applied to them).


## The Future

At the moment, there are no proposals to expand the current set of resource hints. However, priority hints and native lazy loading are two proposed technologies that are similar in spirit to resource hints in that they provide APIs for optimizing the loading process.


### Priority Hints

[Priority hints](https://wicg.github.io/priority-hints/) are an API for expressing the fetch priority of a resource a resource: `high`, `low`, or `auto`. They can be used with a wide range of HTML tags: specifically `<image>`, `<link`>, `<script>`, and `<iframe>`.

For example, if you had an image carousel, priority hints could be used to prioritize the image that users see immediately and deprioritize later images.

```html
<carousel>

  <img src="cat1.jpg" importance="high">

  <img src="cat2.jpg" importance="low">

  <img src=”cat3.jpg” importance=”low”>

</carousel>
```

Priority hints are [implemented](https://www.chromestatus.com/feature/5273474901737472) and can be tested via feature flag in Chromium browsers versions 70 & up. Given that it is still an experimental technology, it is unsurprising that it is only used by 0.04% of sites.

85% of priority hint usage is with `<img>` tags. Priority hints are mostly used to deprioritize resources: 72% of usage is `importance=”low”`; 28% of usage is `importance=”high”`.


### Native lazy loading

[Native lazy loading](https://web.dev/native-lazy-loading) is a native API for deferring the load of off-screen images and iframes. This frees up resources during the initial page load and avoids loading assets that are never used. Previously, this technique could only be achieved through third-party JavaScript libraries.

The API for native lazy loading looks like this:

```html
<img src=”cat.jpg” loading=”lazy”>
```

Native lazy loading is available in browsers based on Chromium 76 & up. The API was announced too late for it to be included in the data set for this year’s almanac, but it is something to keep an eye out for in the coming year.


## Conclusion

Overall, this data seems to suggest that there is still room for further adoption of resource hints. Most sites would benefit from adopting and/or switching to preconnect from dns-prefetch. A much smaller subset of sites would benefit from adopting prefetch and/or preload. There is greater nuance in successfully using prefetch and preload - which constrains its adoption to a certain extent - but the potential payoff is also greater. HTTP/2 Push and the maturation of machine learning technologies is also likely to increase the adoption of preload and prefetch.
