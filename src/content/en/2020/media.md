---
#See https://github.com/HTTPArchive/almanac.httparchive.org/wiki/Authors'-Guide#metadata-to-add-at-the-top-of-your-chapters
part_number: I
chapter_number: 5
title: Media
description: Media chapter of the 2020 Web Almanac covering image file sizes and formats, responsive images, client hints, lazy loading, accessibility and video.
authors: [tpiros, bseymour, eeeps]
reviewers: [nhoizey, colinbendell, dougsillars]
analysts: [smatei]
editors: [bazzadp]
translators: []
tpiros_bio: Tamas Piros is a Developer Evangelist, Google Developer Expert and Technical Trainer.
bseymour_bio: Ben Seymour is a Dynamic Media & Content Specialist at <a href="https://cloudinary.com/">Cloudinary</a>.
eeeps_bio: Eric Portis is a Web Platform advocate at <a href="https://cloudinary.com/">Cloudinary</a>.
discuss: 2041
results: https://docs.google.com/spreadsheets/d/1SZGpCsTT0u1MFBrxed7HA9FLAloL1dS8ZIng986LvS8/
queries: 05_Media
#featured_quote: TODO
#featured_stat_1: TODO
#featured_stat_label_1: TODO
#featured_stat_2: TODO
#featured_stat_label_2: TODO
#featured_stat_3: TODO
#featured_stat_label_3: TODO
unedited: true
---

## Introduction
Today, we live in the world of the visual web, where media provides the soul for websites. Websites use both images and videos, in different shapes and formats to engage with audiences. However, online media not only serves a purpose to engage an audience but it also exists to tell a visual story, to convenience or to entertain.

## Images

{# TODO (authors) we don't like empty headings so can we have an intro sentence or two here? #}

### Responsive HTML markup for Images

While there are myriad approaches to embedding media using javascript, we were interested in the ongoing uptake of varying forms of HTML markup being employed directly. Several ‘Responsive Images’ approaches including picture element, and srcset (within img or source element) have had growing support since first introduced in 2015.

#### Srcset

Srcset enables the User Agent to attempt to determine the most appropriate media asset to load from a candidate list’

For example:

```html
<img srcset="images/example_3x.jpg 3x, images/example_2x.jpg 2x"
     src="images/example.jpg" alt="..." />
```

Around 26.5% of all pages now include `srcset`

The number of images presented to the User Agents to choose from has direct implications for two main performance factors:
1. Image breakpoints for performance budget
2. Caching efficiencies

The fewer the number of image candidates, the greater the likelihood of the asset being cached, and if a CDN is being used, the greater the likelihood of it being available on a client’s nearest edge. However the greater the difference in media dimensions, the more likely we are to end up serving media which is less suited to the device and context in question.

##### Srcset: Quantity of Image Candidates

{{ figure_markup(
  image="srcset-number-of-candidates.png",
  caption="Srcset number of candidates.",
  description="Bar chart showing number of candidates on desktop and mobile. Most pages have 1-3 Candidates (58.82% on desktop, and 60.01% on mobile) especially if we extend to 1-5 candidates (82.79% on desktop and 83.52% on mobile). After that the drop off is sharp with 5-10 Candidates	only having 13.12% on desktop and 12.42% on mobile. 10-15 Candidates is down to 1.96% on desktop and 1.87% on mobile and 15-20 Candidates has 0.55% on desktop 0.53% on mobile",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vTLNnD9VNqXNxMu60VovxIEp_L6vmNo1oWt8-C18DOetXB3qIkee_-KjZwYYPIkkIM-7So-5wBwQ4QY/pubchart?oid=761924614&format=interactive",
  sheets_gid="1848992988",
  sql_file="image_srcset_candidates.sql"
  )
}}

A greater number of dimensional variants of each image tends will typically have implications on the complexity of the media pipeline or service in use, and will secondarily have implications on the required media storage, as well as the caching efficiencies already mentioned.

In some platforms, such as Wordpress, there are approaches which once rolled out on the platform, can of course influence the approaches taken by a large number of sites.

##### Srcset: Descriptors

When providing the candidate list to the User Agent, we have 2 mechanisms with which we can inform the context for each provided image: x-descriptor and  w-descriptor.

X-descriptor describes the device pixel ratio of the specific resource, ie 2x would indicate that the specific image resource is of twice the dimensional size in each axis , hence four times as many pixels, an x-descriptor of 3x means nine times the number of pixels, which of course can have considerable payload implications.

```html
<img srcset="images/example_3x.jpg 3x, images/example_2x.jpg 2x"
     src="images/example.jpg" alt="..." />
```

W-descriptor describes the pixel width of the specific resource.

```html
<img srcset="images/example_small.jpg 600w, images/example_medium.jpg 1400w, images/example_large..jpg 2400w"
     src="images/example_fallback.jpg" alt="..." />
```

Both approaches enable the User Agent to mathematically factor in device pixel ratio when assessing the most appropriate image candidate.

{{ figure_markup(
  image="srcset-descriptor-usage.png",
  caption="Srcset descriptor usage.",
  description="Bar chart showing ",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vTLNnD9VNqXNxMu60VovxIEp_L6vmNo1oWt8-C18DOetXB3qIkee_-KjZwYYPIkkIM-7So-5wBwQ4QY/pubchart?oid=1336533401&format=interactive",
  sheets_gid="1370415291",
  sql_file="image_srcset_descriptor.sql"
  )
}}

In the early days of responsive images, some browsers only supported x-descriptor, but clearly the w-descriptor is by far the most favoured.

While it can be common to choose image candidates which are spaced by dimension, for example widths of  720px,  1200px, 1800px there are also approaches to give more linear payload steps, for example say a series of images which are say 50kb in difference.

Tools like the [Responsive Image Breakpoints Generator](https://www.responsivebreakpoints.com/) can be useful in facilitating this.

#### Sizes

Without ’sizes’ the user agent will make its calculations on the basis that the image takes the full width of the viewport.

For example:

```html
<img sizes="(min-width: 640px) 50vw, 100vw"
     srcset="images/example_small.jpg 600w, images/example_medium.jpg 1400w, images/example_large..jpg 2400w,"
     src="images/example_fallback.jpg" alt="..." />
```

{{ figure_markup(
  image="srcset-sizes-usage.png",
  caption="Use of sizes in srcset.",
  description="Bar chart showing ",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vTLNnD9VNqXNxMu60VovxIEp_L6vmNo1oWt8-C18DOetXB3qIkee_-KjZwYYPIkkIM-7So-5wBwQ4QY/pubchart?oid=496958447&format=interactive",
  sheets_gid="768487310",
  sql_file="image_srcset_sizes.sql"
  )
}}

For the 2020 data around 35% of sites using srcset did not also combine it with sizes, while this may well be appropriate, we regularly encounter instances where this oversight means that the maths to determine the most appropriate image candidate is flawed, often leading to images of unnecessarily large dimension being requested.


Many people that we have discussed this with express that this aspect of the responsive images syntax is one area they cause concerns due to the need to ensure alignment between the layout as managed and determined by CSS and the relevant logic being in the markup for responsive images.

#### Picture

While srcset and sizes provides us with the tooling to help provide browsers with images which are dimensionally more suited for a given viewport, device and layout - the Picture element gives us further capabilities to provide more sophisticated media strategies including leveraging more effective image formats, and empowering us to explore Art Direction for our media too.

##### Picture: Format Switching

While there are some services and imageCDNs which can provide auto-format switching from a single image reference, we can also achieve similar behaviours using standard markup with the picture element.

```html
<picture>
    <source type="image/webp" srcset="images/example.webp" />
    <img src="images/example.jpg" alt="..." />
</picture>
```

Current uptake shows around 19% of pages being served using the picture element are doing so at least in part in relation to format switching.

{{ figure_markup(
  image="use-of-picture.png",
  alt="Use of picture.",
  caption="Use of `<picture>`.",
  description="Bar chart showing ",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vTLNnD9VNqXNxMu60VovxIEp_L6vmNo1oWt8-C18DOetXB3qIkee_-KjZwYYPIkkIM-7So-5wBwQ4QY/pubchart?oid=416496535&format=interactive",
  sheets_gid="1719719920",
  sql_file="picture_format_distribution.sql"
  )
}}

Breaking this down into the number of formats offered:

{{ figure_markup(
  image="picture-number-of-formats.png",
  alt="picture number of formats.",
  caption="`<picture>` number of formats.",
  description="Bar chart showing ",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vTLNnD9VNqXNxMu60VovxIEp_L6vmNo1oWt8-C18DOetXB3qIkee_-KjZwYYPIkkIM-7So-5wBwQ4QY/pubchart?oid=1963933588&format=interactive",
  sheets_gid="1719719920",
  sql_file="picture_format_distribution.sql"
  )
}}

Of pages using picture for format switching, around 68% are offering a single type variation, in addition to the img src which acts as the default.

{{ figure_markup(
  image="picture-format-usage-by-type.png",
  caption="Picture format usage by type.",
  description="Bar chart showing ",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vTLNnD9VNqXNxMu60VovxIEp_L6vmNo1oWt8-C18DOetXB3qIkee_-KjZwYYPIkkIM-7So-5wBwQ4QY/pubchart?oid=775091522&format=interactive",
  sheets_gid="1719719920",
  sql_file="picture_format_distribution.sql"
  )
}}

Here is an example of the markup syntax that could be used to offer multiple format variants:

```html
<picture>
  <source type="image/avif" srcset="images/example.avif" />
  <source type="image/webp" srcset="images/example.webp" />
  <source type="image/jp2" srcset="images/example.jp2" />
  <source type="image/vnd.ms-photo"  srcset="images/example.jxr" />
  <img src="images/example.jpg" alt="Description" />
</picture>
```


The User Agent will effectively select the first one that it has a positive match on, and hence the ordering logic here is important.

Of those pages using picture for format switching, 83% offer WebP as one of the format variants, which in part relates to it’s growing browser support.

The formats being supported by different browser is a movable feast: WebP has now got much broader support across the browsers:
WebP : 90% coverage (Edge, Firefox, Chrome, Opera, Android)   (https://caniuse.com/webp)
JPEG 2000 : 18.5% coverage (Safari) (https://caniuse.com/jpeg2000)
JPEG XR: : 1.7% coverage (IE) (https://caniuse.com/jpegxr)
AVIF : 25% coverage (Chrome, Opera) (https://caniuse.com/avif)


There are also considerations around the capabilities available through the different formats, for example PNG supports transparency, making WebP a good alternative where supported, as it also supports transparency.

Consider offering AnimatedGIFs as WebP for improved efficiency, or instead as a muted autoplaying video - though this will have implications for the markup approach, and media processing needs.


There are 3 aspects to be balanced to aligned this type of format switching approach:
The browser development activities to support different media formats
The necessary pipeline and processes to create the needed media in these formats
Implementing the markup to then express the logic to support the formats.

Several of the Dynamic Media Services and ImageCDNs can help greatly simplify this by automating it, and endeavouring to track and keep in sync with the browser manufacturer updates.

<p class="note">Note: AVIF has been supported in Chrome since 85 (released late August 2020), hence the data for this Almanac is predominantly from prior to this time. However running an ad hoc query on more recent data from early November 2020 is already showing tens of thousands of AVIF requests.</p>

##### Picture: Media Art Direction

The media Art Direction capabilities offered by the picture element start to enable us to provide the kind of sophisticated viewport dependent media manipulation that we have been considering for text and typography for some time.

Considering how poorly wide short media such as banners can work when squeezed into more narrow layouts, considering adapting the aspect ratio of the served media, or even the image visual payload itself, depending on the media queries expressed in picture source is, in our opinion, an underutilised capability.

In this example, we are changing out the aspect ratio of the served media, from square (1:1) to 4:3 and eventually 16:9 depending on the viewport width, endeavouring we make the best use of the available space for our media:

```html
<picture>
  <source media="(max-width: 780px)"
          srcset="image/example_square.jpg, image/example_square_2x.jpg 2x" />
  <source media="(max-width: 1400px)"
          srcset="image/example_4_3_aspect.jpg, image/example_4_3_aspect.jpg 2x" />
  <source srcset="image/example_16_9_aspect.jpg, image/example_16_9_aspect_2x.jpg 2x"/>
  <img src="image/example_fallback.jpg" alt="..." />
</picture>
```

##### Picture: Orientation Switching

While the data shows that only a little under 1% of pages using picture make use of orientation, this feels like an area that warrants further exploration from website designers and developers.

{{ figure_markup(
  image="picture-usage-of-orientation.png",
  alt="Picture usage of orientation.",
  caption="`<picture>` usage of orientation.",
  description="Bar chart showing ",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vTLNnD9VNqXNxMu60VovxIEp_L6vmNo1oWt8-C18DOetXB3qIkee_-KjZwYYPIkkIM-7So-5wBwQ4QY/pubchart?oid=56906843&format=interactive",
  sheets_gid="283790776",
  sql_file="picture_orientation.sql"
  )
}}

Considering smaller devices, both in terms of the constraints of the available space to express ourselves, but also how easy and natural it is to turn the device in-hand, to be in portrait or landscape mode, there is some interesting potential for using the orientation media query.

Example syntax:

```html
<picture>
  <source srcset="images/example_wide.jpg"
          media="(min-width: 960px) and (orientation: landscape)">
  <source srcset="images/example_tll.jpg"
          media="(min-width: 960px) and (orientation: portrait)">
  <img src="..." alt="..." />
</picture>
```

### Effective leveraging of more effective image formats

{# TODO (authors) - can we have a sentence here to avoid an empty heading? #}

#### MIME Types vs extensions

This section is rather interesting, we can observe a high distribution of extensions and various spelling of the same extension (jpg vs JPG vs jpeg vs JPEG). In some cases the mime type is also specified incorrectly. For example - image/jpeg is the correct and recognised mime type for JPEG images. However we can see that 0.02% of all the pages that use JPEG have specified the incorrect mime type on both clients. Furthermore we can see that an extension of pnj was used 28,420 times (likely to be a typo) and its mime time was set to image/jpeg.

{{ figure_markup(
  image="image-usage-by-extension.png",
  caption="Image usage by extension.",
  description="Bar chart showing ",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vTLNnD9VNqXNxMu60VovxIEp_L6vmNo1oWt8-C18DOetXB3qIkee_-KjZwYYPIkkIM-7So-5wBwQ4QY/pubchart?oid=1607248506&format=interactive",
  sheets_gid="402973893",
  sql_file="image_mimetype_ext.sql"
  )
}}

We have seen further inconsistencies between extensions and mime types - for example jpeg delivered with a mime type of webp, however it is likely that some of these are natural artefacts caused by Image CDN delivery services with on-the-fly transformation and optimisation capabilities.

#### Progressive JPEGs

We also looked at the usage of progressive JPEGs on the web. WebPageTest gives each page a "score," which adds up all of the JPEG bytes that were loaded from Progressive-ly encoded JPEGs, and divides it by the total number of JPEG bytes that *could* have been progressively encoded. The majority (57%) of pages served less than 25% of their JPEG-bytes, progressively. This represents a large opportunity for no-downsides compression savings, that's yet to be taken despite years of Progressive JPEGs being a best practice and modern encoders like MozJPEG encoding progressively by default.

{{ figure_markup(
  image="progressive-jpeg-score.png",
  caption="Progressive JPEG score.",
  description="Bar chart showing ",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vTLNnD9VNqXNxMu60VovxIEp_L6vmNo1oWt8-C18DOetXB3qIkee_-KjZwYYPIkkIM-7So-5wBwQ4QY/pubchart?oid=1693689151&format=interactive",
  sheets_gid="1834242483",
  sql_file="score_progressive_jpeg.sql"
  )
}}

### Microbrowsers

Let us turn now to the topic of [microbrowsers](https://24ways.org/2019/microbrowsers-are-everywhere/). Also known as "link unfurlers" and "link expanders," these are the user agents that request webpages and grab bits and pieces from them to assemble rich previews when links are shared in messaging or on social media. The *lingua franca* of microbrowsers is Facebook's [Open Graph protocol](https://ogp.me), so we looked at what percentage of webpages are including images and video specifically targeted towards microbrowsers in Open Graph `<meta>` tags.

A third of web pages include images, in Open Graph tags, for microbrowsers. But only around 0.1 percent of pages include microbrowser-specific *videos*; just about every page that included a video, also included an image.

A third of sampled webpages seems very healthy; the power of relational, word-of-mouth marketing combined with microbrowser-tailored rich previews is clearly worth investing in.

Given that video content is expensive to produce and much less common on the web than images, we understand the comparatively low usage. But the fact that videos are often playable and even autoplayable from within the link previews themselves, without requiring a trip to a full-on browser, means that this is a big opportunity for boosting engagement.

The Open Graph protocol only allows for *one* image or video URL to be included; there is none of the context-adaptive flexibility offered by <picture> and `srcset`. So, authors tend to be rather conservative when picking formats to send to microbrowsers. Fully half of all microbrowser-specific images are JPEGs; 45 percent are PNGs; a hair under 2 percent are Gifs. WebPs only account for 0.2% of images for microbrowsers.

Likewise, on the video front, the vast majority of resources are sent in the lowest-common-denominator format: MP4. We are  mystified as to why the second most popular format is the [now-depreciated](https://blog.adobe.com/en/publish/2017/07/25/adobe-flash-update.html#gs.my93m2) SWF, and curious whether these are playable in any microbrowser.

### Usage of CDNs vs Local Domain for Storing & Delivering Media

{# TODO (authors) - can we have a sentence here to avoid an empty heading? #}

#### Usage of `data-url` vs `src` attribute

Using data URLs (formerly known as data URIs) is a technique that allows developers to embed a base64 encoded image to a webpage. There are several benefits to using this solution (fast load times being one) but has several drawbacks as well (size). The usage of these doesn’t seem to be that widespread, 0.9% of the pages utilise data URLs for displaying images.

#### `rel=preconnect`

In some cases, resources displayed on a page would come from another origin. In this case the ‘rel=preconnect’ attribute can be used on a link element to advice browsers about this fact. Note that useful it may seem to add this option to your site, since it’s a relatively cheap operation, there could be situations when additional CPU time is going to be utilised by establishing such connections. Interesting enough both on desktop and mobile we have seen a tiny amount of pages utilising this technique on desktop and mobile: 0.000054%, 0.000016% respectively.

### SEO & Accessibility

{# TODO (authors) - can we have a sentence here to avoid an empty heading? #}

#### The Usage of `alt` Text

The ‘alt’ attribute for images is used to provide a description of the image. Albeit being an optional attribute, it is immensely useful for accessibility since screen-readers would read the alt text. Furthermore it’s useful for situations when the image doesn’t load - in that case the text is shown.

{{ figure_markup(
  image="image-alt-usage-by-page.png",
  caption="Image alt usage by page.",
  description="Bar chart showing ",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vTLNnD9VNqXNxMu60VovxIEp_L6vmNo1oWt8-C18DOetXB3qIkee_-KjZwYYPIkkIM-7So-5wBwQ4QY/pubchart?oid=2144814052&format=interactive",
  sheets_gid="885941461",
  sql_file="image_alt.sql"
  )
}}

Around 96% of all the pages processed had an img element - 21% of these images had the alt attribute missing. 52% of the images had the alt attribute available, however 26% of these were left blank.

#### Figure & Figcaption

With HTML5, amongst other things, semantic elements were added to the language. These semantic elements give semantic meaning to content found within an HTML page. One element is the figure element which can, optionally use a fig caption element as its child. The main, and key difference between using a “simple” image tag (img) with a paragraph to describe the image versus using figure using a fig caption for description is that the former will semantically group the content about the figure together.

{{ figure_markup(
  image="figure-and-figcaption-usage-by-page.png",
  caption="Figure and Figcaption usage by page.",
  description="Bar chart showing ",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vTLNnD9VNqXNxMu60VovxIEp_L6vmNo1oWt8-C18DOetXB3qIkee_-KjZwYYPIkkIM-7So-5wBwQ4QY/pubchart?oid=605432940&format=interactive",
  sheets_gid="2037389060"
  )
}}

{# TODO (analyst) - what's the SQL file for this? #}

We can see that roughly 12% of the pages on both desktop and mobile use the figure element, however only roughly 1% use figcaption to add a description.

## Videos

{# TODO (authors) - can we have a sentence here to avoid an empty heading? #}

### The `<video>` element

The `<video>` element forms the core of video delivery on the web, and is used either on its own or in conjunction with Javascript players which progressively enhance it to deliver video.

### Sources (or not), and total usage

There are two ways to use a `<video>`. You can either stick a single resource URL into the `src` attribute on the element itself, or give it any number of child `<source>` elements, which the browser peruses until it finds a source it thinks it can load. Our first query looks at how often we see each of these patterns across all sampled pages.

{{ figure_markup(
  image="video-usage-of-src-versus-source.png",
  caption="Video usage of Src versus Source.",
  description="Bar chart showing ",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vTLNnD9VNqXNxMu60VovxIEp_L6vmNo1oWt8-C18DOetXB3qIkee_-KjZwYYPIkkIM-7So-5wBwQ4QY/pubchart?oid=2100955508&format=interactive",
  sheets_gid="689453572"
  )
}}

{# TODO (analyst) - what's the SQL file for this? #}

Twice as many `<video>`s have `<source>` children, vs a `src` attribute, indicating that authors want the ability to send different resources to different end users, depending on their context, rather than sending a single lowest-common-denominator resource to everyone (or, alternately, giving some portion of their audience a worse, or broken, experience).

Also interestingly, we can see that, across all pages, only a percent or two contain `<video>` elements at all. It’s far less common than `<img>`!

### Javascript Players

We looked for the presence of a few common players (hls.js, video.js, Shaka Player, JW Player, Brightcove Player, and Flowplayer); pages with these particular players are less than half as common as pages that use the native `<video>` element.

{{ figure_markup(
  image="video-element-versus-javascript-player.png",
  caption="Video element versus JavaScript player.",
  description="Bar chart showing ",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vTLNnD9VNqXNxMu60VovxIEp_L6vmNo1oWt8-C18DOetXB3qIkee_-KjZwYYPIkkIM-7So-5wBwQ4QY/pubchart?oid=202644434&format=interactive",
  sheets_gid="1489710615",
  sql_file="video_tag_and_js_player.sql"
  )
}}

The analysis is complicated a bit by the fact that many players – such as video.js – enhance in-source `<video>` elements. Only 5-6% of the pages that used the searched-for players *also* included a `<video>` element, but evidence of this pattern is actually more visible when we look at the values of `type` attributes, within `<video>` and `<source>` elements.

### Type attributes

{{ figure_markup(
  image="video-source-types.png",
  caption="Video source types.",
  description="Bar chart showing ",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vTLNnD9VNqXNxMu60VovxIEp_L6vmNo1oWt8-C18DOetXB3qIkee_-KjZwYYPIkkIM-7So-5wBwQ4QY/pubchart?oid=203419864&format=interactive",
  sheets_gid="1459916814",
  sql_file="video_source_types.sql"
  )
}}

Unsurprisingly, by far the most common type value is `video/mp4`. But the second most common – making up 15% of all desktop `type`s, and 20% of all `type`s  sent to the mobile crawler, is `video/youtube` – which is not a registered MIME type at all. Rather it's a special value that several players (including WordPress') use when embedding YouTube videos. A few notches down the list, we see a similar pattern, for Vimeo embeds.

As for the legitimate MIME types; they capture *container* formats; MP4 and WebM are the only two in anything we might call common use. It would be interesting to know which *codecs* are being used within these containers, and how much traction next-gen codecs like VP8, HVEC, and AV1 have gotten. But such analysis is, unfortunately, outside the scope of this article.

### Preload

{{ figure_markup(
  image="video-preload-values.png",
  caption="Video preload values.",
  description="Bar chart showing ",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vTLNnD9VNqXNxMu60VovxIEp_L6vmNo1oWt8-C18DOetXB3qIkee_-KjZwYYPIkkIM-7So-5wBwQ4QY/pubchart?oid=989934821&format=interactive",
  sheets_gid="1099175973",
  sql_file="video_preload_values.sql"
  )
}}

The preload attribute is indicating for the browser whether a video should be downloaded, and it can have 4 values - none, metadata, auto and empty. (Note that if left empty, the auto value is assumed). We can see that 4.81% of the pages have video elements, and 45.37% of these have the preload attribute. The numbers on mobile are slightly different, with only 3.59% of the pages having video elements and 43.38% of these have the preload attribute.

### Autoplay and Muted

{{ figure_markup(
  image="video-autoplay-and-muted-usage.png",
  caption="Video autoplay and muted usage.",
  description="Bar chart showing ",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vTLNnD9VNqXNxMu60VovxIEp_L6vmNo1oWt8-C18DOetXB3qIkee_-KjZwYYPIkkIM-7So-5wBwQ4QY/pubchart?oid=1010709511&format=interactive",
  sheets_gid="1366238292",
  sql_file="video_autoplay_muted.sql"
  )
}}

Looking at additional information about videos, we can see that 57.22% of the video elements on desktop have the autoplay attribute, 56.36% of pages with a video element on desktop utilise the muted attribute and last but not least 48.74% of  pages use both autoplay and muted on desktop. The numbers are similar for mobile, where 53.86% have autoplay, 53.41% have muted and 45.99% have both autoplay and muted.

## Conclusion

The web is an amazing place to tell a visual story. During our research we could see that the web is truly utilising a lot of elements of media. This diversity is also shown in the number of ways media is represented on the web today. The most basic features of displaying these elements are being actively used, however using modern browsers we could do a lot more. Some of the advanced media features are being used today (sometimes, incorrectly tough), and we’d like to encourage everyone to go a level deeper. Use all the features and capabilities of the modern web to bring more amazing visual experiences to the end user.
