---
#See https://github.com/HTTPArchive/almanac.httparchive.org/wiki/Authors'-Guide#metadata-to-add-at-the-top-of-your-chapters
title: Structured Data
description: Structured Data chapter of the 2021 Web Almanac covering adoption and impact of schema.org, RDFa, Microdata and more.
authors: [jonoalderson, cyberandy]
reviewers: [vdwijngaert, philbarker]
analysts: [GregBrimble]
translators: []
editors: [jvandriel, JasmineDWillson]
results: https://docs.google.com/spreadsheets/d/1uEA217YjpX1xdRVBnIz9ekjpjIrpGIh5GwUxvnzJNig/edit?usp=sharing
jonoalderson_bio: Jono Alderson is a digital strategist, marketing technologist, and full stack developer. He enjoys dabbling with website performance, technical SEO, schema.org and all things structured data.
cyberandy_bio: Andrea Volpini is the CEO of WordLift, and is currently focusing on the semantic web, SEO and artificial intelligence.
featured_quote: Describing our content using structured data enables machines to treat webpages and websites as databases. That creates a wealth of possibilities for business, technology, and society.
featured_stat_1: TODO
featured_stat_label_1: TODO
featured_stat_2: TODO
featured_stat_label_2: TODO
featured_stat_3: TODO
featured_stat_label_3: TODO
---


## Introduction

When reading web pages, we consume _unstructured_ content. We read paragraphs, examine media, and consider what we digest. As part of that process, we apply intuition and context (such as subject-matter familiarity) to identify key themes, data points, entities, and relationships. As humans, we're very good at this.

But this kind of intuition and context is difficult for _software_ to replicate. It's difficult for systems to reliably parse, identify, and extract key themes with a high degree of reliability.

These limitations can constrain the kinds of things which we can effectively build and create, and limits how 'smart' web technology can be.

By introducing _structure_ to information, we can make it _much_ easier for software to 'understand' content. We do this by adding labels and metadata which identify key concepts and entities - as well as their properties and relationships.

When machines can reliably extract structured data, at scale, we enable new and smarter types of software, systems, services and businesses.

The goal of the Web Almanac's Structured Data chapter is to explore how structured data is currently being used across the web. We hope that this will provide insight into the landscape, the challenges, and the opportunities at hand.

This is the first time that this chapter has been included in the Web Almanac, and so we unfortunately lack historical data for the purposes of comparison. Future chapters will also explore year-on-year trends.


## Key concepts

### The semantic web

When we add structured data to public webpages - and we define the entities that those pages contain (or are about, or reference) - we create a form of [linked data](https://en.wikipedia.org/wiki/Linked_data).

We make _statements_ about the things in (and related to) our content in the form of '[triples](https://en.wikipedia.org/wiki/Semantic_triple)'. Statements like, "This _article_ was _authored_ by this _person_", or "That _video _is _about_ a _cat_".

Describing our content in this way enables machines to treat webpages and websites as databases. At scale, it creates a [semantic web](https://www.techrepublic.com/article/an-introduction-to-tim-berners-lees-semantic-web/); a giant global database of information.

<p class="note">"The Semantic Web is the name of a long-term project started by W3C with the stated purpose of realizing the idea of having data on the Web defined and linked in a way that it can be used by machines not just for display purposes, but for automation, integration, and reuse of data across various applications"[https://www.techrepublic.com/article/an-introduction-to-tim-berners-lees-semantic-web/](https://www.techrepublic.com/article/an-introduction-to-tim-berners-lees-semantic-web/)</p>

That creates a wealth of possibilities for business, technology, and society.

### Search engines, and beyond

To date, some of the broadest consumers of structured data are _search engines_ and _social media platforms_.

In most major search engines, website owners may become eligible for various forms of '[rich results](https://developers.google.com/search/docs/advanced/structured-data/search-gallery)' (which may influence visibility and traffic) by implementing various types of structured data on their websites.

[ image demonstrating rich results concept ]

In fact, search engines have played such a significant role in the general adoption of (and [education](https://developers.google.com/search/docs/advanced/structured-data/intro-structured-data) arond) structured data across the web, that this chapter was born out of Web Almanac [SEO chapters from previous years](https://almanac.httparchive.org/en/2020/seo#structured-data). In recent years, the influence of search engines has also popularized [schema.org](https://schema.org/) the vocabulary of choice for structured data.

In addition to this, social media platforms rely on structured data to influence how they read and display content when it's shared (or linked to) on their platforms. Rich previews, tailored titles and descriptions, and interactivity in these platforms are often 'powered' by structured data.

But there's more to see and understand here than search engine optimization and social media benefits. The scale, variety, impact and _potential_ of structured data goes far beyond rich results, far beyond search engines, and far beyond schema.org.

For example, structured data facilitates:



* Easier topic modelling and clustering across multiple pages, websites and concepts; enabling new types of research, comparison and services.
* Enriching analytics data, to allow for deeper and horizontalized analysis of content and performance.
* Creating a unified (or at least, connected) language and syntax for querying business systems and website content.
* Semantic Search; using the same rich metadata used for search engine optimization, to create and manage internal search systems.

Whilst the findings of our research is inevitably shaped by the influence of search engines, we hope to also explore other types, formats, and use-cases of structured data.


## Types of structured data and coverage

Structured data comes in many formats, standards, and syntaxes. We've collected data about the most common of these across our data set.

Specifically, we've identified and extracted structured data relating to:



* [Schema.org](http://schema.org/)
* [Dublin core](https://www.dublincore.org/specifications/dublin-core/)
* Meta tags used by social networks:
    * [Open Graph](https://ogp.me/)
    * [Twitter](https://developer.twitter.com/en/docs/twitter-for-websites/cards/guides/getting-started)
    * [Facebook](https://developers.facebook.com/docs/sharing/webmasters/)
* [Microformats](http://microformats.org/) (and [microformats2](https://microformats.org/wiki/microformats2))
* [RDFa](https://en.wikipedia.org/wiki/RDFa), [Microdata](https://en.wikipedia.org/wiki/Microdata_(HTML)) and [JSON-LD](https://json-ld.org/)

Collectively, these provide a broad overview of different use-cases and scenarios; and include both 'legacy' standards and modern approaches (e.g., microformats vs JSON-LD).

Before we explore specific usage across the various structured data types, we should briefly explore some caveats.


### Data caveats


#### 1. The influence of content management systems

Many of the pages we've evaluated are from websites which use a [content management system](https://en.wikipedia.org/wiki/Content_management_system) (or 'CMS'; such as [WordPress](https://wordpress.org/) or [Drupal](https://www.drupal.org/)). These systems - or the themes/plugins/modules which enhance their functionality - are often responsible for generating the HTML markup which contains the structured data which we're analysing.

That means that our findings are unavoidably skewed to aligning with the behaviours and output of the most prevalent CMS'. For example, many websites using Drupal automatically output structured data in the form of `RDFa`, and WordPress (which powers over X% of websites) often includes `microformats` in template code. This contributes significantly to the shape of our findings.


#### 2. The limitations of homepage-only data

Unfortunately, the nature and scale of our data-collection methods limit our analysis to _homepages only_ (i.e., the root URL of each hostname we evaluate).

This significantly limits the amount of data we can collect and analyse, and, undoubtedly skews the _kinds_ of data we've collected.

As most homepages act as 'portals' to more specific pages, we can reasonably expect that our analysis underestimates the prevalence of the kinds of content present on that 'deeper' pages. That likely includes information relating to _articles_, _people_, _products_ and similar.

[ visualize; homepages linking to more specific deeper pages ]

Conversely, we likely _over-index_ on information typically found on homepages, and 'site-wide' information which is present on all pages - like information about _webpages_, _websites_ and _organizations_.


#### 3. Data overlaps

The nature of some structured data formats makes it hard to perform this kind of analysis 'cleanly' at scale. In many cases, structured data is implemented in multiple (often overlapping) formats, and the lines between syntaxes and vocabularies get blurred.

For example, Facebook and Open Graph metadata are technically a _subset_ of RDFa. That means that our research identifies a page containing a Facebook meta tag in our 'Facebook' category, _and_ our 'RDFa' section. We've done our best to clean, normalize, and make sense of these types of overlaps and nuances.


### Usage by type

We can see that there's a broad range of different types of structured data across _many o_f the pages in our set.



<p id="gdcalert1" ><span style="color: red; font-weight: bold">>>>>>  gd2md-html alert: inline image link here (to images/image1.png). Store image on your image server and adjust path/filename/extension if necessary. </span><br>(<a href="#">Back to top</a>)(<a href="#gdcalert2">Next alert</a>)<br><span style="color: red; font-weight: bold">>>>>> </span></p>


![alt_text](images/image1.png "image_tooltip")


We can also see that _RDFa_ and _Open Graph tags_ in particular are extremely prevalent; appearing on 60.61% and 57.45% of pages respectively.

At the other end of the scale, 'legacy' formats, like _Microformats_ and _microformats2_, appear on fewer than 1% of pages.


### Coverage by syntax type

In addition to identifying when a certain type of structured data is present, we collect information on the types of data it describes. We can break each of these down, and explore how each format and syntax is being used.


#### RDFa

[RDFa](https://www.w3.org/TR/rdfa-lite/) (Resource Description Framework in Attributes) is a technology for linked data markup, which was introduced by W3C in 2015. It allows users to augment and translate visual information on a web page by adding additional attributes to markup.

E.g., a website owner might add a `rel="license"` attribute to a hyperlink in order to explicitly describe it as a link to a licensing information page (`&lt;a href="/license/" rel="license">Licensing information&lt;/a>)`.



<p id="gdcalert2" ><span style="color: red; font-weight: bold">>>>>>  gd2md-html alert: inline image link here (to images/image2.png). Store image on your image server and adjust path/filename/extension if necessary. </span><br>(<a href="#">Back to top</a>)(<a href="#gdcalert3">Next alert</a>)<br><span style="color: red; font-weight: bold">>>>>> </span></p>


![alt_text](images/image2.png "image_tooltip")


When we evaluate the _types _of RDFa, we can see that the `foaf:image` syntax is present on far more pages than any other type - on upwards of 0.86% of all pages in our data set. Whilst that may seem like a small proportion, it represents over ~65,000 pages, and over 60% of the total RDFa markup that we discovered.

Beyond this outlier, the use of RDFa diminishes and fragments considerably, though there are still some interesting discoveries to explore.


##### On FOAF

[FOAF](http://xmlns.com/foaf/spec/) is a linked data dictionary of people-related terms, created in the early-2000s. It can be used to describing _people_, _groups _and _documents_.

FOAF uses W3C's RDF syntax and in its [original introduction](https://web.archive.org/web/20140331104046/http://www.foaf-project.org/original-intro) was explained as follows: "_Consider a Web of inter-related home pages, each describing things of interest to a group of friends. Each new home page that appears on the Web tells the world something new, providing factoids and gossip that make the Web a mine of disconnected snippets of information. FOAF provides a way to make sense of all this_."

Anecdotally, we can attribute a prominence of `foaf:` markup in our results to sites running on older versions of the Drupal CMS; which historically added `typeof="foaf:image"` and `foaf:document` markup to its HTML by default.


##### On other notable RDFa findings

As well as FOAF properties, various other standards and syntaxes show up in our list.

Notably, we can see several 'sioc' properties, such as `sioc:item` (0.24% of pages) and `sioc:useraccount` (0.03% of pages). [SIOC](https://www.w3.org/Submission/sioc-spec/) is a standard designed to describe structured data relating to _online communities_, such as message boards, forums, wikis and blogs.

We can also see a [SKOS](https://www.w3.org/TR/skos-primer/) property - `skos:concept` - on 0.04% of pages. SKOS is another standard, which aims to provide a way of describing taxonomies and classifications (e.g., tags, data sets, and so on).


#### Dublin Core

[Dublin Core](https://dublincore.org/) is a vocabulary interoperable with linked data standards that was originally conceived in Dublin, Ohio in 1995 at an OCLC (Online Computer Library Center) and NCSA (National Center for Supercomputing Applications) workshop.

It was designed to describe a broad range of resources (both digital and physical) and can be used in various business scenarios. Starting in 2000 it became extremely popular among RDF-based vocabularies and received the adoption of the W3C.

Since 2008 it is managed by DCMI (Dublin Core Metadata Initiative (DCMI) and remains highly interoperable with other linked data vocabularies. It is typically implemented as a collection of meta tags in a HTML document.



<p id="gdcalert3" ><span style="color: red; font-weight: bold">>>>>>  gd2md-html alert: inline image link here (to images/image3.png). Store image on your image server and adjust path/filename/extension if necessary. </span><br>(<a href="#">Back to top</a>)(<a href="#gdcalert4">Next alert</a>)<br><span style="color: red; font-weight: bold">>>>>> </span></p>


![alt_text](images/image3.png "image_tooltip")


That the most popular attribute type is `dc:title` (on 0.7% of pages) comes as no surprise; but it is interesting to see that `dc:language` is next (above common descriptors like _description_, _subject_ and _publisher_) with a penetration of 0.49%. This makes sense, when you consider that Dublin Core is often used in multilingual metadata management systems.

It's also interesting to see the relatively prominent appearance of  `dc:relation` (on 0.16% of pages) - an attribute that is capable of expressing relationships between different concepts.

While it might seem to many that Schema.org is predominant in the context of SEO, the role of DC remains pivotal because of its broad interpretation of concepts and its deep roots in the _linked open data movement_.


#### Social metadata


##### Open Graph

[The Open Graph protocol](https://ogp.me/) is an open source standard, originally created by Facebook. It is a type of structured data specific to the context of _sharing content_, based loosely on Dublin Core, Microformats and similar standards.

It describes a series of meta tags and properties, which may be used to define how content should be (re)presented when shared between platforms. E.g., when 'liking' or embedding a post, or sharing a link.

These tags are typically implemented in the `&lt;head>` of a HTML document, and define elements such as the page's _title_, _description_, _URL_, and _featured image_.

[ visualize embedded post ]

The Open Graph protocol has since been broadly adopted by many platforms and services; including _Twitter_, _Skype_, _LinkedIn_, _Pinterest_, _Outlook _and more. When platforms don't have their own standards for how shared/embedded content should be presented (and sometimes, even when they do), Open Graph tags are often used to define the default behaviour.



<p id="gdcalert4" ><span style="color: red; font-weight: bold">>>>>>  gd2md-html alert: inline image link here (to images/image4.png). Store image on your image server and adjust path/filename/extension if necessary. </span><br>(<a href="#">Back to top</a>)(<a href="#gdcalert5">Next alert</a>)<br><span style="color: red; font-weight: bold">>>>>> </span></p>


![alt_text](images/image4.png "image_tooltip")


The most common type of Open Graph tag is the `og:title`, which can be found on an incredible 54.87% of pages. That's followed closely by a set of related attributes, which describe what _type_ of thing is being represented (e.g., `og:type`, on 48.18% of pages) and _how_ it should be represented (e.g., `og:description`, on 48.55% of pages).

This narrow distribution is to be expected, as these tags are often used together as part of a 'boilerplate' set of tags used in the `&lt;head>` across all pages on a site.

Slightly less common is `og:locale` (26.39% of pages), which is used to define the language of the page's content.

Less common still is more specific metadata about the `og:image` tag, in the form of `og:image:width` (12.95% of pages), `og:image:height` (12.91% of pages), `og:image:secure_url` (5.61% of pages) and `og:image:alt` (1.75% of pages).

Beyond these examples, usage drops off rapidly, into a long-tail of (often malformed, deprecated or erroneous) tags.


##### Twitter

Though Twitter uses Open Graph tags as fallbacks and defaults, the platform supports its own flavour of structured data. A set of specific meta tags (all prefixed with `twitter:`) can be used to define how pages should be presented when URLs are shared on Twitter.



<p id="gdcalert5" ><span style="color: red; font-weight: bold">>>>>>  gd2md-html alert: inline image link here (to images/image5.png). Store image on your image server and adjust path/filename/extension if necessary. </span><br>(<a href="#">Back to top</a>)(<a href="#gdcalert6">Next alert</a>)<br><span style="color: red; font-weight: bold">>>>>> </span></p>


![alt_text](images/image5.png "image_tooltip")


The most common Twitter meta tag is `twitter:card`, which was found on 35.42% of all pages. This tag can be used to define how pages should be presented when shared on the platform (e.g., as a 'summary', or as a 'player' when paired with additional data about a media object).

Beyond this outlier, adoption drops off steeply. The next most common tags are `twitter:title` and `twitter:description` (both also used to define how shared URLs are presented), which appear on 20.86% and 18.68% of all pages, respectively.

It's understandable why these particular tags - as well as the `twitter:image` tag (11.41% of pages) and `twitter:url` tag (3.13% of pages) - aren't more prevalent, as Twitter falls back to the equivalent Open Graph tags (`og:title`, `og:description` and `og:image`) when they're not defined.

Also of interest are:



* The `twitter:site` tag (11.31% of pages) which defines the Twitter account associated with the website in question.
* The `twitter:creator` tag (3.58% of pages), which defines the Twitter account of the author of the webpage's content.
* The `twitter:label1` and `twitter:data1` tags (both on 6.85% of pages), which can be used to define custom data and attributes about the webpage. Additional label/data pairs (e.g., `twitter:label2` and `twitter:data2`) are also present on a significant number (0.5%) of pages.

Beyond these examples, usage drops off rapidly, into a long-tail of (often malformed, deprecated or erroneous) tags.


##### Facebook

In addition to Open Graph tags, Facebook supports additional metadata (meta tags, prefixed with `fb:`) for relating webpages to specific brands, properties and people on their platform.



<p id="gdcalert6" ><span style="color: red; font-weight: bold">>>>>>  gd2md-html alert: inline image link here (to images/image6.png). Store image on your image server and adjust path/filename/extension if necessary. </span><br>(<a href="#">Back to top</a>)(<a href="#gdcalert7">Next alert</a>)<br><span style="color: red; font-weight: bold">>>>>> </span></p>


![alt_text](images/image6.png "image_tooltip")


Of all of the Facebook tags that we detected, there are only three tags with significant adoption.

Those are `fb:app_id`, `fb:admins`, and `fb:pages`; which we found on 6.06%, 2.63% and 0.86% of pages respectively.

These tags are used to explicitly relate a webpage to a Facebook Page/Brand, or to grant permissions to a user (or users)  who administrates those profiles.

Anecdotally, it's unclear how well these are supported by Facebook. The platform has gone through radical changes over the past few years, and their technical documentation hasn't been well-maintained. However, many content management systems, templates and best practice guides - as well as some of Facebook's debugging tools - still include and make reference to them.


##### Microformats (and microformats2)

Microformats, commonly abbreviated as `μF`, are an open data standard for metadata to embed semantics and structured data in HTML.

They are composed of a set of defined classes that describe the meanings behind normal HTML elements, such as headings and paragraphs.

The guiding principle behind this format for structured data is to convey semantics by ​reusing widely adopted standards (semantic (X)HTML). The [official documentation](https://microformats.org/wiki/what-are-microformats) describes Microformats as "designed for humans first and machines second", and are "a set of simple, open data formats built upon existing and widely adopted standards".

Microformats are available in two versions: Microformats v1 and Microformats v2 (microformats2). The latter, introduced in March 2014,  replaces and supersedes v1 and takes advantage of some important lessons learned from both microdata and rdfa syntaxes.



<p id="gdcalert7" ><span style="color: red; font-weight: bold">>>>>>  gd2md-html alert: inline image link here (to images/image7.png). Store image on your image server and adjust path/filename/extension if necessary. </span><br>(<a href="#">Back to top</a>)(<a href="#gdcalert8">Next alert</a>)<br><span style="color: red; font-weight: bold">>>>>> </span></p>


![alt_text](images/image7.png "image_tooltip")


Historically and due to its nature (as an extension of HTML), Microformats have been heavily used by website developers to describe properties of businesses and organizations; particularly in pages promoting local businesses. This goes a long way to explaining the prominence of the `adr` property (on 0.5% of pages), reviews (`hReview`, on 0.06% of pages) and other information meant to characterize local businesses and their products/services.



<p id="gdcalert8" ><span style="color: red; font-weight: bold">>>>>>  gd2md-html alert: inline image link here (to images/image8.png). Store image on your image server and adjust path/filename/extension if necessary. </span><br>(<a href="#">Back to top</a>)(<a href="#gdcalert9">Next alert</a>)<br><span style="color: red; font-weight: bold">>>>>> </span></p>


![alt_text](images/image8.png "image_tooltip")
The difference between legacy microformats and the more modern version is significant, and an interesting insight into changing behaviours and preferences in the use of markup.

Where the `adr` class dominated the classic microformats data set, the equivalent `h-adr` property only occurs on 0.02% of pages. The results here are dominated instead by the `h-entry` property (on 0.08% of pages; which describes blog posts and similar content 'units'), and the `h-card` property (on 0.04% of pages; which describes a 'business card' of an organization or individual).

We can speculate on three likely causes for this difference:



* Data for common class names (like `adr`) is almost certainly over-inflated in our microformats v1 data; where it's difficult to distinguish between when these values are used for _structured data_ vs more _generic_ reasons (e.g., as a HTML class attribute value with associated CSS rules).
* The use of microformats in general (regardless of type) has decreased significantly, and been replaced with other formats, and;
* Many websites and themes still include `h-entry` (and sometimes `h-card`) markup on common design elements and layouts. E.g., many WordPress themes continue to output a `h-entry` class on the main content container.


#### Microdata

Like microformats and RDFa, [microdata](https://en.wikipedia.org/wiki/Microdata_(HTML)) is based on adding attributes to HTML elements. Unlike microformats, but in common with RDfa, it's not tied to a set of defined meanings. The standard is extensible, and allows authors to declare which vocabularies of data they're describing; most commonly schema.org.

One of the limitations of microdata is that it can be difficult to describe abstract or complex relationships between entities, when those relationships aren't explicitly reflected in the HTML structure of the page.

For example, it may be hard to describe the _opening hours_ of an _organization_ if that information isn't concurrent or logically structured in the document. Note that, there are standards and methodologies for solving this problem (e.g., by including inline `&lt;meta>` tags and properties), but these aren't widely adopted.



<p id="gdcalert9" ><span style="color: red; font-weight: bold">>>>>>  gd2md-html alert: inline image link here (to images/image9.png). Store image on your image server and adjust path/filename/extension if necessary. </span><br>(<a href="#">Back to top</a>)(<a href="#gdcalert10">Next alert</a>)<br><span style="color: red; font-weight: bold">>>>>> </span></p>


![alt_text](images/image9.png "image_tooltip")


The most common types of microdata across the pages we analysed describe the webpage itself; via properties like `webpage` (7.44% of pages), `sitenavigationelement` (5.62% of pages), `wpheader` (4.87% of pages) and `wpfooter` (4.56% of pages).

It's easy to speculate on why these types of 'structural' descriptors are more prominent than 'content' descriptors (such as `person` or `product`); creating and maintaining microdata requires content producers to add specific code to their content - and that's often easier to do at 'template' level than it is at 'content' level.

Whilst one of the strengths of microdata is its explicit relationship with (and authoring in) the HTML markup, this has limited its approach to content authors with the technical knowledge and capabilities to use it.

That said, we see a broad adoption and variety of microdata types. Of note:



* `Organization` (4.02%), which typically describes the company which _publishes_ the website, the _manufacturer _of a product, the _employer_ of an author, or similar.
* `CreativeWork` (2.14%) the most generic 'parent' type to describe all written and visual content; e.g., blog posts, images, video, music, art.
* `BlogPosting` (1.34%), which describes an individual blog post (which commonly also identifies a `Person` as an author).
* `Person` (1.37%) which is often used to describe content authors and people related to the page (e.g., the publisher of the website, the owner of the publishing organization, the individual selling a product, etc).
* `Product` (1.22%) and `Offer` (1.09%), which, when used together, describe a product which is available for purchase (typically with additional properties which describe pricing, reviews and availability).


#### JSON-LD

Unlike microdata and microformats, [JSON-LD](https://json-ld.org/) isn't implemented by adding properties or classes to HTML markup. Instead, machine-readable code is added to the page as one or more standalone 'blobs' of JavaScript. This code contains descriptions of the entities on the page, and their relationships.

Because the implementation isn't tied directly to the HTML structure of the page, it can be much easier to describe complex or abstract relationships, as well as representing information which isn't readily available in the human-readable content of the page.



<p id="gdcalert10" ><span style="color: red; font-weight: bold">>>>>>  gd2md-html alert: inline image link here (to images/image10.png). Store image on your image server and adjust path/filename/extension if necessary. </span><br>(<a href="#">Back to top</a>)(<a href="#gdcalert11">Next alert</a>)<br><span style="color: red; font-weight: bold">>>>>> </span></p>


![alt_text](images/image10.png "image_tooltip")
 \
As we might expect, our findings are similar to our findings from evaluating the use of microdata. That's to be expanded, as both approaches are heavily skewed towards the use of schema.org as a predominant standard. However, there are some interesting differences.

Because the JSON-LD format allows for site owners to describe their content independently of the HTML markup, it can be easier to represent more abstract complex relationships, which aren't tied so strictly to the content of the page.

We can see this reflected in our findings; where more specific and structured descriptors are more common than with microdata. E.g:



* `BreadcrumbList` (1.45% of pages) describes the hierarchical position of the webpage in the website (and describes each 'parent' page).
* `ItemList` (0.5% of pages), which describes a 'set' of entities; such as _steps_ in a _recipe_, or _products_ in a _category_.

Outside of these examples, we continue to see a similar pattern as we did with microdata (though at a much lower scale). Descriptions of websites, local businesses, organizations and the structure of webpages account for the majority of broad adoption.


##### JSON-LD structures & relationships

One key advantage of JSON-LD is that we can more easily describe the _relationships_ between entities than we can in other formats.

An _event_, for example, may have an organizing _corporation_, be located at a specific _location_, and have tickets available on sale as part of an _offer_. A _blog post _describing that event might have an _author_, and so on, and so on. Describing these kinds of relationships is much easier with JSON-LD than with other syntaxes, and can help us tell rich stories about entities.

However, these relationships can often become deep, complex and intertwined. So for the purposes of this analysis, we're only looking at the most common _types_ of relationships between entities; not evaluating entire trees and relationship structures.

Below are the most common connections between types, based on how frequently they occur within _all_ structure/relationship values. Note that some of these structures and values may sometimes _overlap_, as they're small parts of larger relationship chains.


<table>
  <tr>
   <td><em>SUM of pct_pages</em>
   </td>
   <td><em>client</em>
   </td>
   <td>
   </td>
  </tr>
  <tr>
   <td><em>Combined</em>
   </td>
   <td>desktop
   </td>
   <td>mobile
   </td>
  </tr>
  <tr>
   <td>WebSite > potentialAction > SearchAction
   </td>
   <td><p style="text-align: right">
24.79%</p>

   </td>
   <td><p style="text-align: right">
24.29%</p>

   </td>
  </tr>
  <tr>
   <td>
   </td>
   <td><p style="text-align: right">
19.35%</p>

   </td>
   <td><p style="text-align: right">
19.04%</p>

   </td>
  </tr>
  <tr>
   <td>@graph > WebSite
   </td>
   <td><p style="text-align: right">
18.96%</p>

   </td>
   <td><p style="text-align: right">
18.67%</p>

   </td>
  </tr>
  <tr>
   <td>WebPage > isPartOf > WebSite
   </td>
   <td><p style="text-align: right">
15.62%</p>

   </td>
   <td><p style="text-align: right">
15.19%</p>

   </td>
  </tr>
  <tr>
   <td>@graph > WebPage
   </td>
   <td><p style="text-align: right">
15.59%</p>

   </td>
   <td><p style="text-align: right">
15.13%</p>

   </td>
  </tr>
  <tr>
   <td>BreadcrumbList > itemListElement > ListItem
   </td>
   <td><p style="text-align: right">
13.92%</p>

   </td>
   <td><p style="text-align: right">
13.58%</p>

   </td>
  </tr>
  <tr>
   <td>@graph > BreadcrumbList
   </td>
   <td><p style="text-align: right">
12.35%</p>

   </td>
   <td><p style="text-align: right">
11.93%</p>

   </td>
  </tr>
  <tr>
   <td>WebPage > potentialAction > ReadAction
   </td>
   <td><p style="text-align: right">
11.35%</p>

   </td>
   <td><p style="text-align: right">
10.83%</p>

   </td>
  </tr>
  <tr>
   <td>WebPage > breadcrumb > BreadcrumbList
   </td>
   <td><p style="text-align: right">
10.13%</p>

   </td>
   <td><p style="text-align: right">
9.74%</p>

   </td>
  </tr>
  <tr>
   <td>WebSite
   </td>
   <td><p style="text-align: right">
9.41%</p>

   </td>
   <td><p style="text-align: right">
8.89%</p>

   </td>
  </tr>
  <tr>
   <td>@graph > Organization
   </td>
   <td><p style="text-align: right">
8.75%</p>

   </td>
   <td><p style="text-align: right">
8.48%</p>

   </td>
  </tr>
  <tr>
   <td>WebSite > publisher > Organization
   </td>
   <td><p style="text-align: right">
8.64%</p>

   </td>
   <td><p style="text-align: right">
8.36%</p>

   </td>
  </tr>
  <tr>
   <td>Organization > logo > ImageObject
   </td>
   <td><p style="text-align: right">
8.24%</p>

   </td>
   <td><p style="text-align: right">
8.12%</p>

   </td>
  </tr>
  <tr>
   <td>@graph > ImageObject
   </td>
   <td><p style="text-align: right">
6.82%</p>

   </td>
   <td><p style="text-align: right">
6.66%</p>

   </td>
  </tr>
  <tr>
   <td>WebPage > primaryImageOfPage > ImageObject
   </td>
   <td><p style="text-align: right">
6.49%</p>

   </td>
   <td><p style="text-align: right">
6.36%</p>

   </td>
  </tr>
  <tr>
   <td>Organization > image > ImageObject
   </td>
   <td><p style="text-align: right">
6.33%</p>

   </td>
   <td><p style="text-align: right">
6.00%</p>

   </td>
  </tr>
  <tr>
   <td>Organization
   </td>
   <td><p style="text-align: right">
6.44%</p>

   </td>
   <td><p style="text-align: right">
5.99%</p>

   </td>
  </tr>
  <tr>
   <td>WebPage > about > Organization
   </td>
   <td><p style="text-align: right">
5.83%</p>

   </td>
   <td><p style="text-align: right">
5.58%</p>

   </td>
  </tr>
</table>


 \
The most common structure is the relationship between `website`, `potentialAction`, and `SearchAction` schema (accounting for 6.15% of structures). Collectively, this relationship enables the use of a '[Sitelinks Search Box](https://developers.google.com/search/docs/advanced/structured-data/sitelinks-searchbox)' in Google's search results.

Perhaps most interestingly, the next most popular structure (4.85% of relationships) defines _no_ relationships. These pages output only the simplest types of structured data; defining individual, isolated entities and their properties.

The next most popular structure (4.69% of relationships) introduces the `@graph` property (in conjunction with describing a `website`). The `@graph` property doesn't is not an entity in its own right, but can be used in JSON-LD to 'contain' and group relationships between entities.

As we explore further relationships, we can see various descriptions of content and organizational relationships, such as `WebPage > isPartOf > WebSite` (3.81% of relationships), `Organization > logo > ImageObject` (3.03% of relationships), and `WebSite > publisher > Organization` (2.09% of relationships).

We can also see lots of structures related to breadcrumb navigation, such as:



* `BreadcrumbList > itemListElement > ListItem` (3.78% of relationships)
* `@graph > BreadcrumbList` (2.99% of relationships)
* `ItemList > itemListElement > ListItem` (1.69% of relationships)

Beyond these most popular structures, we see an extremely long-tail of relationships, describing all manner of entities, content types and concepts; as niche as `ApartmentComplex > amenityFeature > LocationFeatureSpecification` (0.1% of relationships) and `AutoDealer > department > AutoRepair` (0.04% of relationships) and `MusicEvent > performer > PerformingGroup` (0.01% of relationships).

We should re-iterate that these types of structures and relationships are likely to be much more common than our data set represents, as we're limited to analysing the 'homepages' of websites. That means that, for example, a website which lists many thousands of individual _apartment complexes_, but does so on 'inner pages', wouldn't be reflected in this data.


##### Relationship depth

Out of curiosity, we also calculated the deepest, most complex relationships between entities - in both our mobile and desktop data sets.

Deeper relationships _tend_ to equate to richer, more comprehensive descriptions of entities (and the other entities they're related to).

The deepest relationships are:



* On desktop, a depth of 18 nested connections.
* On mobile, a depth of 12 nested connections.

It's worth considering that these levels of depth may hint at _programmatic generation_ of output, rather than _hand-crafted markup_, as these structures become challenging to describe and maintain at scale.


##### Use of 'sameAs'

One of the most powerful use-cases for structured data to declare when an entity is the 'sameAs' another entity. Building a comprehensive understanding of a _thing_ often requires consuming information which exists in multiple locations and formats. Having a way in which each of those instances can cross-reference the others makes it much easier to 'connect the dots' and to build a richer understanding of that entity.

Because this is such a powerful tool, we've taken the time to explore some of the most common types of `sameAs` usage and relationships.



<p id="gdcalert11" ><span style="color: red; font-weight: bold">>>>>>  gd2md-html alert: inline image link here (to images/image11.png). Store image on your image server and adjust path/filename/extension if necessary. </span><br>(<a href="#">Back to top</a>)(<a href="#gdcalert12">Next alert</a>)<br><span style="color: red; font-weight: bold">>>>>> </span></p>


![alt_text](images/image11.png "image_tooltip")


The `sameAs` property accounts for 1.6% of all JSON-LD markup, and is present on 13.03% of pages.

We can see that the most common values of the `sameAs` property (normalizing from _URLs_ to _hostnames_) are 'social media' platforms (e.g., facebook.com, instagram.com), and 'official sources' (e.g., wikipedia.org, yelp.com) - with the sum of the former accounting for ~75% of usage.

It's clear that this property is primarily used to identify the social media accounts of websites and businesses; likely motivated by Google's historical reliance on this data as an input for managing 'knowledge panels' in their search results. Given that this requirement was [deprecated in 2019](https://twitter.com/googlesearchc/status/1143558928439005184), we might expect this data set to gradually alter in coming years.


## Conclusion

Structured data is used broadly, and diversely, across the web. Whilst some of this is undoubtedly 'stale' (legacy sites/pages, using outmoded formats), there is also strong adoption of new and emerging standards.

Anecdotally, much of the adoption we see of modern standards like schema.org (particularly via JSON-LD) appears to be motivated by organizations and individuals who wish to take advantage of search engines' support (and rewards) for providing data about their pages and content. But outside of this, there's a rich landscape of people who use structured data to enrich their pages for other reasons. They describe their websites and content so that they can integrate with other systems, so that they can better understand content, or in order to facilitate _others_ to tell _their own_ stories and build their own products.

A web made of deeply connected, structured data which powers a more integrated world has long been a science-fiction dream. But perhaps, not for much longer. As these standards continue to evolve, and their adoption continues to grow, we pave a road towards an exciting future.


### Future years

As this is the first time this chapter has been included in the Web Almanac, we don't have any data we can use to explore change over time.

In future years, we'll be able to assess how the distribution, types, and formats of structured data have changed across the web. This may provide valuable insight into growing/declining technologies, strategies, and opportunities.

We look forward to exploring further.
