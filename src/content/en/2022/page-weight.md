---
#See https://github.com/HTTPArchive/almanac.httparchive.org/wiki/Authors'-Guide#metadata-to-add-at-the-top-of-your-chapters
title: Page Weight
#TODO - Review and update chapter description
description: Page Weight chapter of the 2022 Web Almanac covering why page weight matters, bandwidth, complex pages, page weight over time, page requests, and file formats.
authors: [fellowhuman1101, dwsmart]
reviewers: [CSteele-gh, mordy-oberstein]
analysts: [drohe]
editors: []
translators: []
results: https://docs.google.com/spreadsheets/d/1JvJMiRsL6T9m_NEBHFh-rrQmU5a-ufdOKriSJbrEN8M/
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

Over the last ten years, mobile page weight has increased 585%. In this time, we've seen performance enhancing technologies emerge to buffer the impact. More recent performance measuring methodologies like eschew page weight as a factor.

Page weight still matters. Whether you're experiencing a weak network connection at an inopportune moment or live in a market  where access to the internet is charged by the megabyte, inflated page weight decreases the availability of information.


## What is page weight?

Page weight refers to the byte size of a web page.  As it's no longer 1994, a web page is rarely only the HTML of the URL viewed in a browser's address bar. Rather a webpage as viewed and rendered in a browser uses specific elements and assets.  

This is why page weight is inclusive of all assets used to create the page. These include: \




* The [HTML](./markup) that makes up the page itself.
* [Images and other media (video, audio, etc)](./media) embedded into the page
* [Cascading Style Sheets (CSS)](./css) used for styling the page
* [JavaScript](./javascript) to provide interactivity
* [Third-Party](./third-parties) resource containing one or more of the above.

Each resource called adds to the byte of the page as well as computational resources involved in the transmission, processing, and rendering of the page.  Some resources like scripts have additional overhead in the form of CPU usage as each must be downloaded, parsed, compiled, and executed.

As page weight balloons, valiant efforts and methods have been proposed to mitigate the impact. Still, the machinations of page weight's complex relationship to resource allocation is invisible to most users. Let's inspect closer the three impacts of page weight for resources:


### Storage

Ultimately every resource that goes to make up a webpage needs to be stored somewhere. For a website, that often means multiple places, all which bring their own costs and overheads.


Storage on the web server tends to be relatively low cost when on disk storage, and relatively scalable. It's perhaps a little more expensive if the web server is serving from memory. These resources might also be duplicated on intermediate caches and CDNs.

That's just the source, ultimately the resources will need to be served in some form on the client side too, where storage is potentially more limited, especially for mobile devices. Serving huge, bloated files may well fill the user's cache, pushing out other useful resources.

Unoptimised images, at resolutions better suited to print media at multiple megabytes, and huge video files can still be routinely found.

A lot of this can be mitigated by picking the right formats and codecs for media, and being mindful of size as well as quality. Services like <a hreflang="en" href="https://squoosh.app/">Squoosh</a> are great for getting the most out of your images at the smallest possible size, and there are specialist [CDNs](./cdn) that can automate much of this.

Media, although regularly the weightiest elements, are not the only place savings can be made, text resources can be compressed and minified too.

Putting your resources on a diet has never been easier!


### Transmission

When you visit a webpage for the first time, all the resources that page requests need to be transmitted across the internet from the server to your device.

That can be across a superfast, high monthly usage broadband connection, but it could be from a slow, expensive, capped mobile connection, or even satellite.

The larger the page weight, the longer this will take. It can also be more expensive for those users with lower capped data plans.

There are optimisations with things like [preconnect, preload and priority hints](./resource-hints) that can manage the order things are loaded and  help perceived load times, but ultimately the resources still need to be transmitted and received, and the best optimisation of all is serving smaller resources.


### Rendering

The fetching of resources is just the first step of getting a website painted on-screen and viewable by the user.

To do that, a web browser needs to render the page, using all the relevant resources.

Page weight plays an important role here, in a number of ways, first if the transmission is slow, because the files are large, the longer it is until the browser gets the chance to even start working on these to render.

Large files have an effect even after they are received over the network. Larger files take more processing power and memory to be read, processed and rendered. Thi in turn leads to longer delays from some, or even all, of the content from being displayed to the user. The longer the delay, the more likely a user is to abandon the page and seek the information from a more responsive site.

JavaScript is of a special concern here, as it not only needs to be downloaded, it needs to be parsed and executed.

Huge files can have an ongoing performance penalty, even if your user does wait for them to be initially downloaded. They can eat up all client-side resources available to the browser, leading to slow performance, or even crashing the browser entirely.

Modern, high-end smartphones, laptops and tablets might have the power to handle these large files without extremely  noticeable performance issues, older or lower-powered devices may well struggle. These are also often the same devices with slow and potentially expensive mobile connections, leading to a 'double penalty' for people who potentially need simple, reliable access the most.


## Assets (What are we shipping?)

Think of assets as a way to view what resources a web page ships in order for a user to view the rendered content in browser. 

Prior to the introduction of HTML 2.0 in 1995, page weights were predictable and manageable. The only asset to weigh was the HTML.  <a hreflang="en" href="https://www.rfc-editor.org/rfc/rfc1866">RFC1866</a> introduced the `<img>` tag.  Page weight dramatically increased as inline images could be included with web pages.

Further versions of the HTML spec added even more features that could add weight, like external CSS, allowing consistent styling across pages.

1996 saw the first emergence of JavaScript, 2005 brought XHR, and 2006 saw the birth of libraries like jQuery, followed by frameworks like Angular, React, Vue and many more, fully unleashing the leviathan in waiting: JavaScript. 

The swell of page weight brought a proliferation of file types intended to improve performance while retaining functionalities.  Examining them by asset type will highlight the trade-offs.


### Images

Images are the poster child for balance between performance enhancing technologies and asset byte size.  These static files serve as resources to build out and render web pages. The increasingly visual nature of the web ensures the media-type will retain its title as most ubiquitous asset.

Older formats like PNG, JPEG, GIF enjoy their legacy of broader "historical" browser support.  Performance-focused file type <a hreflang="en" href="https://developers.google.com/speed/webp">WebP</a> gained significant browser support and is now available to <a hreflang="en" href="https://caniuse.com/webp">97% of global users</a>. 

To delve into the findings and implications of image use on the web, refer to the [Media Chapter](./media).


### JavaScript

JavaScript is the most popular  client-side scripting language on the web.  According to w3Techs, <a hreflang="en" href="https://w3techs.com/technologies/details/cp-javascript">98% of websites</a> use it to create interactive online content.  While magnificent when used in moderation, the intoxicating allure of JavaScript can also lead to serious performance, search engine optimization, and user experience issues.

Refer to [JavaScript Chapter](./javascript) of the for detailed insights into the internet's favorite monkey paw.


### Third-Party Services

A page's weight is not limited to the assets hosted on the origin. Third-party resources requested by the page pile onto the weight in the form of analytics, chatbots, forms, embeds, analytics, A/B testing tools, and data collection.

According to the [Third Parties chapter](./third-parties) of the Web Almanac, 94% of all websites on mobile devices use at least one third-party resource! Each of these contributes to the byte size of page weight.


### Caching

Caching allows a resource to be reused until a specified expiration. Caches are used in browsers and on servers. 

CDNs are a popular example.  These interconnected servers are geographically distributed in order to send cached content from a network location closest to the user. CDNs do not reduce page weight but rather reduce the delay by reducing the distance between requestor and resource.

Both [Caching](./caching) and [CDNs](./cdn) are complex enough to warrant their own chapters.


### Other Assets

The basic building blocks of the web have remained relatively unchanged for over 25 years.  As the richness of web experiences increase, so does the use of fonts and videos.

These increases are in step with the other file weight increases with a notable expectation to the 100th percentile.   

In 2021, the 100th percentile of mobile sites used 20,452 kilobytes of font files.  In 2022, these outliers swelled to 110,404 kilobytes.  At the 90th percentile, the median mobile font weight was 401 kilobytes.

This 540% growth was not seen in the year of year comparison for desktop which sat at 66,257 kilobytes  in 2021 and 68,285 in 2022.

{{ figure_markup(
  caption="The largest font use on mobile page.",
  content="110 MB",
  classes="big-number",
  sheets_gid="1763112644",
  sql_file="bytes_per_type.sql"
)
}}

More insights into the typographical nature of the web can be found in the [Fonts chapter](./2021/third-parties).

Data sets used for the Web Almanac break out HTML, JavaScript, CSS, images, and fonts are their own dimension.  All other file types are analyzed as 'Other' including video, XHR, and Flash resources.

Similar to the extreme inflation of 100th percentile font use, other file types ballooned for mobile sites.  At the 90th percentile, the median mobile other weight was 0 kilobytes.

In 2021, 100th percentile mobile sites shipped 21,523 kilobytes.  In 2022, outliers shipped 122,724 kilobytes– a 570% increase.  The 90th percentile of mobile sites saw a zero kilobyte median. This indicates a large gap in adoption rates for these file types.


## Page weight by the numbers

Overall page weight is remarkably close when looking at what is served desktop versus mobile user-agents, although the gap grows slightly in the higher percentile (larger) pages. Given that mobile devices tend to have less local resources and more constrained network capabilities.

{{ figure_markup(
   image="page-weight-distribution.png",
   caption="Page weight distribution by percentile.",
   description="Bar chart showing the total page weight distribution by percentile. The 10th percentile mobile page loads weigh 445 KB, the 25th 990 KB, the 50th 2,019 KB, the 75th 4,042 KB, and the 90th 8,082 KB.",
   chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vS-yCXlRH7TMaQg1T2YsESIiUNe4BSga5NWwEElHgU3ZaNLXNauwAxsn3k_el5v1fxvtc_YA5k9i689/pubchart?oid=590874210&format=interactive",
   sheets_gid="1763112644",
   sql_file="page_weight_trend.sql"
  )
}}

At the 50th percentile, desktop pages were 2.3 MB, mobile pages 2.0 MB, by the 90th percentile this has grown to a hefty 9.0 MB for desktop, 8.0 MB for mobile.

{{ figure_markup(
  caption="The weight of the largest desktop page",
  content="678 MB",
  classes="big-number",
  sheets_gid="1763112644",
  sql_file="page_weight_trend.sql"
)
}}

At the 100th percentile, the largest pages we detected, desktop users were faced with eye-watering  678 MB pages, and mobile users 390 MB.

<p id="gdcalert3" ><span style="color: red; font-weight: bold">>>>>>  gd2md-html alert: inline image link here (to images/image3.png). Store image on your image server and adjust path/filename/extension if necessary. </span><br>(<a href="#">Back to top</a>)(<a href="#gdcalert4">Next alert</a>)<br><span style="color: red; font-weight: bold">>>>>> </span></p>


![alt_text](images/image3.png "image_tooltip")


A look at the median weight of the most common resource content types making up the weight of pages show images are the largest contributor, at 1,026 KB for desktop pages, 811 KB for mobile. JavaScript is the next biggest contributor, for both desktop and mobile page loads.



<p id="gdcalert4" ><span style="color: red; font-weight: bold">>>>>>  gd2md-html alert: inline image link here (to images/image4.png). Store image on your image server and adjust path/filename/extension if necessary. </span><br>(<a href="#">Back to top</a>)(<a href="#gdcalert5">Next alert</a>)<br><span style="color: red; font-weight: bold">>>>>> </span></p>


![alt_text](images/image4.png "image_tooltip")


Looking at the median page weight over time, it remains clear that the trend remains disappointingly  consistent, with the median weight only growing over time. 

**585%**

(Growth in Mobile Page Weight over 10 years)

In the 10 year period between March  2012 to March 2022, the median page weight increased by 223%, or 1.5 MB, for desktop page loads, 585%, or 1.7 MB for mobile page loads

Year on year, (Jul 2022 versus July 2021) desktop increased from  2,202 KB to 2,312 KB on desktop,  1,948 KB to 2,037 KB on desktop.


### Requests

The number of requests made to create a page can affect the performance of a page, it's not only the total number of bytes requested. We therefore consider this as part of page weight.



<p id="gdcalert5" ><span style="color: red; font-weight: bold">>>>>>  gd2md-html alert: inline image link here (to images/image5.png). Store image on your image server and adjust path/filename/extension if necessary. </span><br>(<a href="#">Back to top</a>)(<a href="#gdcalert6">Next alert</a>)<br><span style="color: red; font-weight: bold">>>>>> </span></p>


![alt_text](images/image5.png "image_tooltip")


The median page (50th percentile) makes 76 requests for desktop page loads, 70 on mobile page loads, the difference between desktop and mobile is minimal.

Last year's median desktop request was 74, so no significant difference over last year.



<p id="gdcalert6" ><span style="color: red; font-weight: bold">>>>>>  gd2md-html alert: inline image link here (to images/image6.png). Store image on your image server and adjust path/filename/extension if necessary. </span><br>(<a href="#">Back to top</a>)(<a href="#gdcalert7">Next alert</a>)<br><span style="color: red; font-weight: bold">>>>>> </span></p>


![alt_text](images/image6.png "image_tooltip")


Breaking down requests by type shows that images are the leading resource requests, with the median page requesting 25 images for desktop page loads, 22 for mobile. This is nearly identical to last year's 25 for desktop, 23 for mobile.

JavaScript is the next largest in request count, 22 requests for desktop page loads, 21 for mobile, again a very close match to 2021, where there were 21 for desktop and 20 for mobile.

In general there's little difference between desktop and mobile, other than images being slightly lower on desktop, perhaps attributable to lazy-loading not firing on smaller initial viewports. 



<p id="gdcalert7" ><span style="color: red; font-weight: bold">>>>>>  gd2md-html alert: inline image link here (to images/image7.png). Store image on your image server and adjust path/filename/extension if necessary. </span><br>(<a href="#">Back to top</a>)(<a href="#gdcalert8">Next alert</a>)<br><span style="color: red; font-weight: bold">>>>>> </span></p>


![alt_text](images/image7.png "image_tooltip")


Whilst images are overall the biggest contributors to page weight across the internet, the biggest contributors in sheer size per request are video, audio and fonts, at the 90th percentile, video requests weigh in at 2,158 KB, far larger than than audio at 222 KB at the 20th percentile. 

Like images, there are a number of opportunities with more modern formats, and better encoding, sizing and compression that could help slim this down. But it's worth noting that video by its nature tends to be weighiter, and there's a balance between size and acceptable quality that needs to be struck. For more information, see the [[Media chapter](https://almanac.httparchive.org/en/2021/media#video)](https://almanac.httparchive.org/en/2021/media#video).



<p id="gdcalert8" ><span style="color: red; font-weight: bold">>>>>>  gd2md-html alert: inline image link here (to images/image8.png). Store image on your image server and adjust path/filename/extension if necessary. </span><br>(<a href="#">Back to top</a>)(<a href="#gdcalert9">Next alert</a>)<br><span style="color: red; font-weight: bold">>>>>> </span></p>


![alt_text](images/image8.png "image_tooltip")


Looking at the median response size for each content type, it's perhaps surprising to see that video content is larger at 268 KB on mobile page loads than desktop ones, at 208 KB. It's quite surprising that the median weight of fonts is higher than images, over double at 20 KB versus 8 KB on mobile.



<p id="gdcalert9" ><span style="color: red; font-weight: bold">>>>>>  gd2md-html alert: inline image link here (to images/image9.png). Store image on your image server and adjust path/filename/extension if necessary. </span><br>(<a href="#">Back to top</a>)(<a href="#gdcalert10">Next alert</a>)<br><span style="color: red; font-weight: bold">>>>>> </span></p>


![alt_text](images/image9.png "image_tooltip")


Focusing on file formats, it's disappointing to see f4v, flash and flv adding significant weight to pages, the flash player plugin was discontinued in 2021, and removed from major browsers like [[Chrome](https://support.google.com/chrome/answer/6258784)](https://support.google.com/chrome/answer/6258784), meaning these bytes are most likely entirely wasted.


### File formats

Since the inception of the Web Almanac images have represented the largest percentage of page weight by bytes.  Distribution of image sizes by formats shows us that JPG, WebP and PNG file formats retain their 2021 status as top sources of image weight. 



<p id="gdcalert10" ><span style="color: red; font-weight: bold">>>>>>  gd2md-html alert: inline image link here (to images/image10.png). Store image on your image server and adjust path/filename/extension if necessary. </span><br>(<a href="#">Back to top</a>)(<a href="#gdcalert11">Next alert</a>)<br><span style="color: red; font-weight: bold">>>>>> </span></p>


![alt_text](images/image10.png "image_tooltip")



### Image bytes

The median desktop image weight for 2022 was 1,026 kilobytes, a mere 44 kilobyte increase from 2021.  Mobile barely shifted at 881 kilobytes.



<p id="gdcalert11" ><span style="color: red; font-weight: bold">>>>>>  gd2md-html alert: inline image link here (to images/image11.png). Store image on your image server and adjust path/filename/extension if necessary. </span><br>(<a href="#">Back to top</a>)(<a href="#gdcalert12">Next alert</a>)<br><span style="color: red; font-weight: bold">>>>>> </span></p>


![alt_text](images/image11.png "image_tooltip")


The year over year consistency is only disrupted by the extremities of the 100th percentile.  The largest desktop page contained 672MB of images, a significant increase from the hefty max of 186MB in 2021.  Similarly, the mobile 100th percentile saw a 959% increase to 385MB. 


### Video bytes

According to the media chapter of the mobile web, 5% of mobile pages include the `video` element.  This information aligns with the 100th percentile of other file type in overall page weight (as video files are grouped in the set). Pages bringing video experiences take on a corresponding increase in weight. 

MP4s, which represent [[51.5% of videos](https://almanac.httparchive.org/en/2022/media#video)](https://almanac.httparchive.org/en/2022/media#video) on the web, also represent the capacity for largest response size.  At the 50th percentile, mp4 response sizes come in at 534 kilobytes.



<p id="gdcalert12" ><span style="color: red; font-weight: bold">>>>>>  gd2md-html alert: inline image link here (to images/image12.png). Store image on your image server and adjust path/filename/extension if necessary. </span><br>(<a href="#">Back to top</a>)(<a href="#gdcalert13">Next alert</a>)<br><span style="color: red; font-weight: bold">>>>>> </span></p>


![alt_text](images/image12.png "image_tooltip")



## Adoption rates of byte-saving technologies


### Facades for Videos & Other Embeds

Videos, and other interactive embeds can massively increase the overall weight of a page. Videos by their nature can be large in terms of bytes, but even things like social media embeds, like embedding a tweet can bring in a substantial amount of JavaScript and other data to enable these to become interactive.

A good design pattern is the use of facades, a form of lazy-loading. This is basically showing a graphical representation of the element, and not loading the full thing in until required. For example, for a YouTube video, the initial load could be just the poster image for the video, an approach taken by the [[popular lite-youtube-embed](https://github.com/paulirish/lite-youtube-embed)](https://github.com/paulirish/lite-youtube-embed) library, which changes to the actual full YouTube embed on click,  or even behaving more like traditional image lazy loading and change when in or near the viewport.

Whilst there are drawbacks to this approach, as detailed in the web.dev article: [https://web.dev/third-party-facades/](https://web.dev/third-party-facades/) the benefits to the user in terms of data sent over the wire are clear, they only need to pay that cost if they want to watch the video, or interact with the live chat app.

In practice, adoption here is hard to track, lighthouse offers a test where it looks at the use of a limited set of third-party resources, and if these are requested, point out there might be a facade available. 

If a site is successfully using a facade, these resources would not be requested, and therefore isn't something lighthouse could test for.

The facade pattern doesn't need to be limited to third party resources either, although these do come with the additional downside of additional lookups and connections, the approach can work well for large self-hosted resources too.

However, analysis showed that there are a number of sites where lighthouse was able to detect that a facade might be beneficial:



<p id="gdcalert13" ><span style="color: red; font-weight: bold">>>>>>  gd2md-html alert: inline image link here (to images/image13.png). Store image on your image server and adjust path/filename/extension if necessary. </span><br>(<a href="#">Back to top</a>)(<a href="#gdcalert14">Next alert</a>)<br><span style="color: red; font-weight: bold">>>>>> </span></p>


![alt_text](images/image13.png "image_tooltip")


9.6% of desktop pages tested could have benefited from implementing a facade, a slightly better 8.8% for mobile visits.


### Compression

Compressing resources before serving them to the client can save bytes that have to be sent across the network, and with less bytes, in theory and usually in practice, this makes for faster loads.

For text,  non-media files, like  [[HTML](https://almanac.httparchive.org/en/2022/markup)](https://almanac.httparchive.org/en/2022/markup), [[CSS](https://almanac.httparchive.org/en/2022/css)](https://almanac.httparchive.org/en/2022/css), [[JavaScript](https://almanac.httparchive.org/en/2022/javascript)](https://almanac.httparchive.org/en/2022/javascript), JSON, or SVG, as well as for woff, ttf and ico filesHTTP compression is a powerful tool, using gzip or brotil compression to squeeze down file size. Media like images and video tend not to see any benefit as they are already compressed.



<p id="gdcalert14" ><span style="color: red; font-weight: bold">>>>>>  gd2md-html alert: inline image link here (to images/image14.png). Store image on your image server and adjust path/filename/extension if necessary. </span><br>(<a href="#">Back to top</a>)(<a href="#gdcalert15">Next alert</a>)<br><span style="color: red; font-weight: bold">>>>>> </span></p>


![alt_text](images/image14.png "image_tooltip")


We detected that 74.4% of page loads on Desktop loads, and a slightly lower 73% of Mobile page loads.

The slightly lower proportion of Mobile usage is a disappointing result, because they are more likely to have slower and more expensive network connections.

Ultimately compression doesn't reduce the whole page weight, because these resources have to be decompressed on the client before they are used.

It's not an entirely free process, either. There is processing overhead on the server to compress (although this might be cacheable for static resources) and likewise a cost on the client side to decompress these resources before use.

It's about tradeoffs and tackling the worst bottleneck, which is often the network. Compression techniques are remarkably efficient, and the net benefit is usually worth it.

You can discover more insights and information over in the[ [Compression Chapter](https://almanac.httparchive.org/en/2022/compression)](https://almanac.httparchive.org/en/2022/compression).


### Minification

[[Minification](https://en.wikipedia.org/wiki/Minification_(programming) ](https://en.wikipedia.org/wiki/Minification_(programming)) helps to reduce the overall size of text-based resources by removing unnecessary characters, like whitespace, code comments and other things that play no part in how a browser interprets and uses these resources.

CSS and JavaScript are great candidates for minification, and we looked at both, using lighthouse's test for these resources.



<p id="gdcalert15" ><span style="color: red; font-weight: bold">>>>>>  gd2md-html alert: inline image link here (to images/image15.png). Store image on your image server and adjust path/filename/extension if necessary. </span><br>(<a href="#">Back to top</a>)(<a href="#gdcalert16">Next alert</a>)<br><span style="color: red; font-weight: bold">>>>>> </span></p>


![alt_text](images/image15.png "image_tooltip")


83.6% of Desktop page loads correctly minified the CSS served, and a smaller 68% of mobile page loads.



<p id="gdcalert16" ><span style="color: red; font-weight: bold">>>>>>  gd2md-html alert: inline image link here (to images/image16.png). Store image on your image server and adjust path/filename/extension if necessary. </span><br>(<a href="#">Back to top</a>)(<a href="#gdcalert17">Next alert</a>)<br><span style="color: red; font-weight: bold">>>>>> </span></p>


![alt_text](images/image16.png "image_tooltip")


76.9% of Desktop page loads correctly minified the JavaScript resources served, and a smaller 63.8% of mobile page loads.

Whilst minification for both CSS and JavaScript is thankfully popular, with the majority of sites getting it right, there's room for improvement still.

It's disappointing that like in compression, minification for mobile users lags behind desktop. Like compression, saving bytes is especially helpful on mobile devices.

Unlike compression, there's no overhead on the client side to minification, resources don't need to be 'unminified' to be used. There can be overhead on the server-side, if the minification is done on-the-fly at serving time, but CSS and JavaScript are likely to be static files, and minification should be done at build time, or before publishing the resource, meaning there is no further overhead.


## Conclusion

WIP

Even though our perception of page performance has shifted away from page weight, 

While page weight is no longer a core consideration in page performance, the size of most pages remain the same. 
