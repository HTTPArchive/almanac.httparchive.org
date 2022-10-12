---
##See https://github.com/HTTPArchive/almanac.httparchive.org/wiki/Authors'-Guide#metadata-to-add-at-the-top-of-your-chapters
title: Structured Data
##TODO - Review and update chapter description
description: Structured Data chapter of the 2022 Web Almanac covering adoption and impact of schema.org, RDFa, Microdata and more.
authors: [cyberandy, DataBytzAI]
reviewers: [SeoRobt, jonoalderson]
analysts: [rviscomi]
editors: [JasmineDW]
translators: []
cyberandy_bio: Andrea Volpini is the CEO of WordLift, and is currently focusing on the semantic web, SEO and artificial intelligence.
DataBytzAI_bio: TODO
results: https://docs.google.com/spreadsheets/d/1iRsyYq4TDMpsgeo_uLq-yqBisHviypeKVUMF1pM1fiM/
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

This is the second year that the Web Almanac has included a chapter on structured data. Last year's content <a hreflang="en" href="https://almanac.httparchive.org/en/2021/structured-data#key-concepts">gave solid grounding</a> in the concept of structured data, outlining the reason it exists, the most frequently used types, and how it benefits organizations. This year we compared data gathered in 2021 with data gathered in 2022, so were able to monitor trends that occurred within that period.

Despite many advances in machine learning and in particular the field of ‘natural language progressing’, data still needs to be presented in a machine-readable format. Structured data assists in information discoverability in web search, data linkage and archival purposes. By implementing structured data on websites, engineers and web content creators facilitate:

- making website data more widely available for automated discovery and linking
- the open availability of data for public research
- ensuring the quality of the organization's data is maintained when the data leaves its origin

Organizations of all sizes and types want their content to be discovered on the web. Search engines such as Google and Bing emphasize data discoverability by promoting the use of structured data. From an SEO point of view, it is advantageous to present data in an easy to find and parse manner. Some of these advantages will be discussed in the [Use Cases](#heading=h.9dgerkhy7i6) and [Key Concepts](#heading=h.sgp4kasx7abv) sections within this chapter.

Last year's introduction pointed out that “when machines can reliably extract structured data, at scale, we enable new and smarter types of software, systems, services and businesses”. This year’s chapter includes sections that explore recently published research on structured data, open source frameworks and tools that assist the generation of high-quality structured data.

This year's chapter provides the first year over year comparison of metrics such as the presence of different structured data types as well as the growth of those structured data types, and examines the evolving benefits of using structured data. Having a baseline of data from 2021 allows us to gain insights into how the use of structured data has changed over the intervening period and observe interesting trends, for example the growth of TikTok in the period.

## Data caveats

Structured data can appear in many forms, and may be more visible in certain domains, and their corresponding websites, over others. For example, compare a news website with an eCommerce website. In general, a news site shows the most important breaking news on its home page, therefore the structured data relating to the news articles may be present on the main website landing page attached as data-snippets to the individual article headlines. In comparison, structured data in eCommerce pertains to individual products and, as such, is mostly present within a website’s product catalog itself, and in many ways, ‘hidden’ from a high level search of the main navigation and promotional parts of the website. This is the key caveat that we need to be aware of in relation to the structured data chapter and report.

Due to the fact that the technology used to harvest data from websites only scratches the surface of sites (ie: the top N pages), and does not go into depth on a full crawl of the site, we are unable to get a full picture of the extent of structured data usage in sites where such data is by necessity, contained deep within the site. In future years we hope to take a sample of sites across different domains and go deep to rectify this issue and give additional insight into domain-specific use of structured data.

The high level caveats from last year’s chapter still remain, namely:

**Auto-generated structured data**
This is where technologies such as content creation systems auto-generate structured data snippets based on templates. In this case any template-based error will inevitably populate across all data presented.

**Data format overlaps**
Structured data can be presented in a number of different ways, including JSON-LD, RDF etc. This means that we may see overlap, for example, between a Facebook meta tag and the same tag presented in a different manner in the RDFa section. As analysis is tightly based on queries created for the baseline in 2021, we expect the impact of cleaning/normalization and data flattening should carry through for like analysis.

## Formats - A year in review

Structured data is underpinned by formats and standards that describe a meta-level schema into which publishers can fit and present data in a pre-defined manner. RDFa, OpenGraph, JSON-LD and other established formats have been used in the analysis for this chapter. Figure 1 illustrates the distribution of structured data types (with a split between mobile and desktop), and Figure 2 shows a comparison in usage of these types between 2021 and 2022. While most of the types have remained reasonably similar in their overall position, the biggest mover seems to be the JSON-LD format which has increased coverage from 33.5% overall in 2021 to 36.5% overall in 2022. This increase of JSON-LD by 3 percentage points is contrasted with the average increase of only 1.2 percentage points for all other formats.

{{ figure_markup(
  image="structured-data-types.png",
  caption="Structured data types",
  description="Structured data types usage in 2022",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRr8oRb8NNs5MbpPpDi7QSsTUTPQL_vxQtQvmn52qGk97gpNhJIHa8VF0x5ZJtWXAFuEbDFZQB6TIuN/pubchart?oid=1295789309&format=interactive",
  sheets_gid="138285863",
  sql_file=""
  )
}}

{{ figure_markup(
  image="structured-data-usage-by-year.png",
  caption="Structured data usage by year",
  description="A year on year comparison of structured data usage",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRr8oRb8NNs5MbpPpDi7QSsTUTPQL_vxQtQvmn52qGk97gpNhJIHa8VF0x5ZJtWXAFuEbDFZQB6TIuN/pubchart?oid=289561022&format=interactive",
  sheets_gid="1452747230",
  sql_file=""
  )
}}

Overall there has been little change in the definitions of the major data types as Table 1 outlines, however some formats have been advanced in specific domains. Only types with changes have been listed:

<figure>
  <table>
    <thead>
      <tr>
        <th>Data type</th>
        <th>Change</th>
      </tr>
    </thead>
    <tbody>
      <tr>
        <td>RDFa</td>
        <td>
          Although there are no changes in the base format of RDFa, version 3 of the  ‘Data Catalog Vocabulary’ (DCAT) contained a significant update. DCAT is an <em>“RDF vocabulary designed to facilitate interoperability between data catalogs published on the Web”</em>. This is significant due to the increased availability of open datasets on the web. Being able to describe the entire contents of a dataset greatly increases the discoverability, and thus usefulness, of a public dataset and makes federated search and distribution more likely.
          <p>
            <em>references:</em>
            <ul>
              <li>DCAT: <a href="https://www.w3.org/TR/2022/WD-vocab-dcat-3-20220510">https://www.w3.org/TR/2022/WD-vocab-dcat-3-20220510</a></li>
              <li>Google <a href="https://datasetsearch.research.google.com/">dataset search engine</a></li>
              <li>Google dataset <a href="https://developers.google.com/search/docs/advanced/structured-data/dataset">structured data format guide</a></li>
            </ul>
          </p>
        </td>
      </tr>
      <tr>
        <td>JSON-LD</td>
        <td>
          Updates and additions in the past year were minor. Of these, most were related to maintenance and minor expansion of context, for example “adding OnlineBusiness as a subtype of Organization and OnlineStore as a subtype of OnlineBusiness”.
          <p>
            <em>References:</em>
            <ul>
              <li><a href="https://schema.org/docs/releases.html">https://schema.org/docs/releases.html</a></li>
            </ul>
          </p>
        </td>
      </tr>
    </tbody>
  </table>
  <figcaption>{{ figure_link(caption="Changes between 2021 and 2022 in data type formats.") }}</figcaption>
</figure>

## Key Concepts

### The Web of Data

As structured data is a rich and complex area, it is important to explore and explain some key concepts of the topic before diving head-first into further analysis.

#### Linked Data

By adding structured data to web pages (be it mobile or desktop web pages), and providing URI links to the entities the pages contain/reference, we create <a hreflang="en" href="https://en.wikipedia.org/wiki/Linked_data">linked data</a>. This structured data is then interlinked, making it more useful through semantic queries.

Adding linked data to describe web page content enables machines to treat web pages as databases. At a large scale, this contributes to the <a hreflang="en" href="https://en.wikipedia.org/wiki/Semantic_Web">semantic web</a>. The semantic web links data together through The Resource Description Framework (RDF). This is a framework for representing information on the web using URIs to define entities and the relationships between them.

A relationship between entities in the RDF data model is known as a semantic triple. With a <a hreflang="en" href="https://en.wikipedia.org/wiki/Semantic_triple">semantic triple</a> (or just triple), we can codify a statement about data. These expressions follow the form of subject–predicate–object (e.g., "Allen knows John").

To be able to retrieve and manipulate RDF data, we can use an RDF Query Language such as <a hreflang="en" href="https://www.w3.org/TR/sparql11-query/">SPARQL</a>, the standard RDF query language.

As will be discussed later, this semantic web creates many opportunities for business and technology.

#### Open Data

Linked data may also be <a hreflang="en" href="https://en.wikipedia.org/wiki/Open_data">open data</a>, described as Linked Open Data. Open data, as the name implies, is data that is openly accessible to anyone for any purpose. This data is licensed under an open license.

Open Data is the first of the <a hreflang="en" href="https://5stardata.info/en/">5 stars of open data</a>, a deployment scheme suggested by Tim Berners-Lee. According to the <a hreflang="en" href="https://opendatahandbook.org/">open data handbook</a>, to score the maximum five stars, data must (1) Be available on the Web under an open license, (2) Be in the form of structured data, (3) Be in a non-proprietary file format, (4) Use URIs as its identifiers, (5) Include links to other data sources (see [data linking](#data-linking)).

While structured data is the second star in the 5 star open data plan, linked data should fulfill requirements for all 5 stars of open data.

### Semantic Search Engines, Rich Results and Beyond

A semantic search engine is one which performs <a hreflang="en" href="https://en.wikipedia.org/wiki/Semantic_search">semantic search</a>. This is different from lexical search where search engines look for exact or close matches to words or strings of text. Semantic search aims to understand the user’s intent and the context of the search terms in order to improve the accuracy of search. An example would be a structured data entity of ‘local business: hairdresser’ versus ‘TG Locks n Lashes’; the latter is a business name, and while it tells the creative name of the hair salon as a key-word, it does little to help the search engine to understand what the business does. By using structured data, the website can better help the search engine understand the context of its information, and thus enable the engine to offer better search results in the context of the query asked by the search user. Google and Bing are excellent examples of semantic search engines.

Google uses semantic search technologies to serve relevant information from the <a hreflang="en" href="https://blog.google/products/search/introducing-knowledge-graph-things-not/">Google Knowledge Graph</a> which is a knowledge base used to serve search results in an infobox. This infobox is known as a <a hreflang="en" href="https://support.google.com/knowledgepanel/answer/9163198">knowledge panel</a>, and can be seen in many results. This is enabled by structured data.

Another search result that is made possible by structured data combined with linked data is the <a hreflang="en" href="https://developers.google.com/search/docs/advanced/structured-data/search-gallery">rich result</a>. These results display richer features in search results, and come in the form of Events, FAQs, How-tos, Job listings and <a hreflang="en" href="https://developers.google.com/search/docs/advanced/structured-data/search-gallery">many more</a>. Implementing structured data to make web pages eligible for rich results <a hreflang="en" href="https://www.searchenginejournal.com/how-important-is-structured-data/257775/">could increase clickthrough rate</a>. Image 1 illustrates how structured data with business details for a Hair Studio allows the search engine to easily extract and display information about the business, highlighting it and optimizing SEO.

{{ figure_markup(
  image="structured-data-surfaced-in-a-web-search.png",
  caption="Structured data surfaced in a web search.",
  description="TODO.",
  width=282,
  height=451
  )
}}

Beyond knowledge panels and web page rich results, structured data can also enable answers to <a hreflang="en" href="https://gofishdigital.com/blog/answering-questions-structured-data/">factual queries</a> in search.  A factual query search can get multiple signals from different structured data sources and support more precise results. Here, structured data implementation, and the technologies that allow for it, provide faster and more reliable access to information in order to improve user experience.

The combination of SEO importance, higher click-through rates, improved user experience and machine-readable data being accessible for analysis illustrate significant benefits to implementing structured data. Understanding these key concepts will help both content providers and technical personnel who construct sites how to implement better navigation and understand the function of automated data consumption from web pages.

## Structured Data Research

For this year's chapter we were interested in investigating what, if any, academic research has been carried out in the area of structured data, or if structured data was documented as being used to assist in development of state-of-the-art technologies and services.

To look for published research, we used academic search tools such as Google Scholar, ConnectedPapers and University-based citation databases. We not only looked for recent publications, but also older research that continues to be cited.

The results of our search showed that there is not a lot of highly cited recent work conducted into generating, managing and building structured web data. However, research on the application of structured web data (semantic web) like knowledge graphs, recommendation engines, information retrieval and explainable AI has been conducted in the past twelve months and continues to grow. Web structured data shares a synergetic relationship with the field of machine learning by providing consistent data with appropriate URI (uniform reference indicator) vocabulary which can be used to generate machine readable <a hreflang="en" href="https://developers.google.com/machine-learning/crash-course/framing/ml-terminology">labels</a>. Our searches and background reading have shown that structured data has considerably reduced the work and time input to generate high quality web data for training machine learning algorithms.

On a practical level, we highlight two areas that structured data has improved:

### Knowledge graphs

Structured web data provides fixed vocabularies between entities and objects as a domain-specific language, which are generally stored in a RDF format. Knowledge graphs using RDF have proven to be great tools for querying relationships between entities. As an example, Wikidated 1.0 is an evolving knowledge graph which uses web structured data to store Wikipedia’s revision history. Its<a hreflang="en" href="https://arxiv.org/abs/2112.05003"> corresponding paper</a> talks through the process of aggregating revisions to a page as a set of additions and deletions of the RDF tuple. The authors have open sourced their method to convert wikipedia dumps into knowledge graphs. Applied research carried out by doordash engineering demonstrates that using [knowledge graphs can dramatically improve search performance] (https://doordash.engineering/2020/12/15/understanding-search-intent-with-better-recall/).

### Explainable AI

Explainable AI focuses on  explaining decisions of an AI model. Most AI models are not openly available to the public, and so do not provide rationale for the decisions they make.  Owing to knowledge graphs built on top of semantic web; harder to find relationships between entities can be found. These are then used as ‘ground truth’ to trace back the results of the model. The most common approach is to map network inputs or neurons to classes of an ontology or entities of a web structured data.

_References:_

- Knowledge graphs: <a hreflang="en" href="https://arxiv.org/abs/2112.05003">https://arxiv.org/abs/2112.05003</a>
- Explainable AI using structured data: <a hreflang="en" href="https://www.researchgate.net/profile/Matthias-Pfaff/publication/336578867_Semantic_Web_Technologies_for_Explainable_Machine_Learning_Models_A_Literature_Review/links/5daafb99a6fdccc99d91d120/Semantic-Web-Technologies-for-Explainable-Machine-Learning-Models-A-Literature-Review.pdf">https://www.researchgate.net/profile/Matthias-Pfaff/publication/336578867_Semantic_Web_Technologies_for_Explainable_Machine_Learning_Models_A_Literature_Review/links/5daafb99a6fdccc99d91d120/Semantic-Web-Technologies-for-Explainable-Machine-Learning-Models-A-Literature-Review.pdf</a>

## Open source use of Structured Data

Three projects of note that rely heavily on the use of structured data are the following:

- [Open Source Metadata Framework (OMF)](http://www.ibiblio.org/osrt/omf/) - The OMF aims to collect data about Open Source documentation / metadata which are typically stored in a structured data format that will be used to describe the documentation. The idea is that the OMF will act as a sophisticated card catalog type of system for the numerous Open Source documentation projects that exist.
- <a hreflang="en" href="https://www.dbpedia.org/">DBpedia</a> is a set of datasets, tools and services related to structured web data. It contains more than 228 million freely-available entities to date. The main DBpedia Knowledge Graph encompasses clean data from Wikipedia. DBPedia is available in all supported Wikipedia languages and averages over 600k file downloads per year. Some open source tools that are built on top of DBpedia provide data access, versioning, quality control, ontology visualization and linking infrastructures.
- <a hreflang="en" href="https://www.wikidata.org/">Wikidata</a> stores structured data from Wikimedia projects like Wikipedia. It is a document-oriented database, which focuses on storing structured web data.

_References:_
- Open Source Metadata Framework - [http://www.ibiblio.org/osrt/omf/](http://www.ibiblio.org/osrt/omf/)
- DBpedia - <a hreflang="en" href="https://en.wikipedia.org/wiki/DBpedia">https://en.wikipedia.org/wiki/DBpedia</a>
- WikiData - <a hreflang="en" href="https://en.wikipedia.org/wiki/Wikidata">https://en.wikipedia.org/wiki/Wikidata</a>

## Year on year comparison

### Usage by type

2022 continues to show a broad range of structured data types used across the pages in our set.

{{ figure_markup(
  image="structured-data-usage-by-year.png",
  caption="Structured data usage by year",
  description="A year on year comparison of structured data usage",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRr8oRb8NNs5MbpPpDi7QSsTUTPQL_vxQtQvmn52qGk97gpNhJIHa8VF0x5ZJtWXAFuEbDFZQB6TIuN/pubchart?oid=289561022&format=interactive",
  sheets_gid="1452747230",
  sql_file=""
  )
}}

RDFa and Open Graph remain in the majority with 62% and 57% of mobile pages, respectively. A general increase in these widely-used structured data types can be seen, including Twitter meta tags and JSON-LD. There is a slight decrease in usage for some of the less prevalent structured data types such as Microdata, Facebook meta tags, Dublin Core and Microformats.

{{ figure_markup(
  image="structured-data-usage-mobile.png",
  caption="Structured Data Usage - Mobile",
  description="A year on year comparison of structured data usage on mobile pages",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRr8oRb8NNs5MbpPpDi7QSsTUTPQL_vxQtQvmn52qGk97gpNhJIHa8VF0x5ZJtWXAFuEbDFZQB6TIuN/pubchart?oid=1513416326&format=interactive",
  sheets_gid="1452747230",
  sql_file=""
  )
}}

Structured data types are seen consistently across mobile and desktop pages, with Microformats and microformats2 differing the most from other structured data types we examined in this chapter. Microformats are 86% as prominent on mobile pages, whereas microformats2 are 171% as prominent on mobile pages. These two structured data types make up a small percentage of those found in our set.

### RDFa

{{ figure_markup(
  image="rdfa-usage-by-year.png",
  caption="RDFa usage by year",
  description="A year on year comparison of RDFa usage",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRr8oRb8NNs5MbpPpDi7QSsTUTPQL_vxQtQvmn52qGk97gpNhJIHa8VF0x5ZJtWXAFuEbDFZQB6TIuN/pubchart?oid=193330933&format=interactive",
  sheets_gid="1452747230",
  sql_file=""
  )
}}

When evaluating the types of RDFa,  `foaf:image` remains present on more pages than any other type, though it has shown a decrease in the percent of pages in our set since 2021. This applies to the next two types, `foaf:document` and `sioc:item`, with small decreases in usage. Many of the other types show a slight increase in usage, as RDFa has seen as a whole.

{{ figure_markup(
  image="rdfa-usage-by-year-mobile.png",
  caption="RDFa usage by year - Mobile",
  description="A year on year comparison of RDFa usage on mobile pages",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRr8oRb8NNs5MbpPpDi7QSsTUTPQL_vxQtQvmn52qGk97gpNhJIHa8VF0x5ZJtWXAFuEbDFZQB6TIuN/pubchart?oid=1434267711&format=interactive",
  sheets_gid="1452747230",
  sql_file=""
  )
}}

{{ figure_markup(
  image="rdfa-usage-by-year-desktop.png",
  caption="RDFa usage by year - Desktop",
  description="A year on year comparison of RDFa usage on desktop pages",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRr8oRb8NNs5MbpPpDi7QSsTUTPQL_vxQtQvmn52qGk97gpNhJIHa8VF0x5ZJtWXAFuEbDFZQB6TIuN/pubchart?oid=1092727710&format=interactive",
  sheets_gid="1452747230",
  sql_file=""
  )
}}

RDFa remains more prominent on desktop with `foaf:image` appearing on 1% of desktop pages, compared to 0.81% on mobile pages. Other RDFa types saw a slight increase in appearance on desktop pages over mobile, with the exception of `og:website` reaching ahead with 0.08% on mobile pages and 0.07% on desktop pages.

### Dublin Core

{{ figure_markup(
  image="dublin-core-usage-by-year.png",
  caption="Dublin Core usage by year",
  description="A year on year comparison of Dublin Core usage",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRr8oRb8NNs5MbpPpDi7QSsTUTPQL_vxQtQvmn52qGk97gpNhJIHa8VF0x5ZJtWXAFuEbDFZQB6TIuN/pubchart?oid=690445913&format=interactive",
  sheets_gid="1452747230",
  sql_file=""
  )
}}

Dublin Core attribute type usage remains very similar across the most prominent attribute types. A notable exception is `dcterms.identifier`, going from 0.11% in 2021 to 0.18% in 2022 for mobile pages. Though small in percentage, this totals to a usage count of nearly 15,000 in our set.

{{ figure_markup(
  image="dublin-core-usage-by-year-mobile.png",
  caption="Dublin Core usage by year - Mobile",
  description="A year on year comparison of Dublin Core usage on mobile pages",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRr8oRb8NNs5MbpPpDi7QSsTUTPQL_vxQtQvmn52qGk97gpNhJIHa8VF0x5ZJtWXAFuEbDFZQB6TIuN/pubchart?oid=1093040433&format=interactive",
  sheets_gid="1452747230",
  sql_file=""
  )
}}

{{ figure_markup(
  image="dublin-core-usage-by-year-desktop.png",
  caption="Dublin Core usage by year - Desktop",
  description="A year on year comparison of Dublin Core usage on desktop pages",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRr8oRb8NNs5MbpPpDi7QSsTUTPQL_vxQtQvmn52qGk97gpNhJIHa8VF0x5ZJtWXAFuEbDFZQB6TIuN/pubchart?oid=2081669606&format=interactive",
  sheets_gid="1452747230",
  sql_file=""
  )
}}

This increase is also seen for desktop pages, though not as substantial, going from 0.14% in 2021 to 0.18% in 2022. Other than that, Dublin Core types are similar between mobile and desktop pages, sharing the same slight increase in appearances compared to the previous year.

### Open Graph

{{ figure_markup(
  image="open-graph-usage-by-year.png",
  caption="Open Graph usage by year",
  description="A year on year comparison of Open Graph usage",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRr8oRb8NNs5MbpPpDi7QSsTUTPQL_vxQtQvmn52qGk97gpNhJIHa8VF0x5ZJtWXAFuEbDFZQB6TIuN/pubchart?oid=1302475483&format=interactive",
  sheets_gid="1452747230",
  sql_file=""
  )
}}

Open Graph tags have seen a widespread increase in use. The most common of these tags is `og:title` appearing in over half of all pages in our set, joined by  `og:url` and `og:type`. Most of these increases are small, with  `og:image:type` as an exception which more than tripled on mobile pages since 2021.

{{ figure_markup(
  image="open-graph-usage-by-year-mobile.png",
  caption="Open Graph usage by year - Mobile",
  description="A year on year comparison of Open Graph usage on mobile pages",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRr8oRb8NNs5MbpPpDi7QSsTUTPQL_vxQtQvmn52qGk97gpNhJIHa8VF0x5ZJtWXAFuEbDFZQB6TIuN/pubchart?oid=1953710107&format=interactive",
  sheets_gid="1452747230",
  sql_file=""
  )
}}

{{ figure_markup(
  image="open-graph-usage-by-year-desktop.png",
  caption="Open Graph usage by year - Desktop",
  description="A year on year comparison of Open Graph usage on desktop pages",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRr8oRb8NNs5MbpPpDi7QSsTUTPQL_vxQtQvmn52qGk97gpNhJIHa8VF0x5ZJtWXAFuEbDFZQB6TIuN/pubchart?oid=1865365764&format=interactive",
  sheets_gid="1452747230",
  sql_file=""
  )
}}

This is matched by desktop, going from 1.57% to 5.38% over the course of the year. We have seen an increase in use for each Open Graph type in the top 10 for both mobile and desktop, resulting in Open Graph’s relative growth of 1.46% since 2021.

### Twitter

{{ figure_markup(
  image="twitter-meta-tag-usage-by-year.png",
  caption="Twitter meta tag usage by year",
  description="A year on year comparison of twitter meta tag usage",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRr8oRb8NNs5MbpPpDi7QSsTUTPQL_vxQtQvmn52qGk97gpNhJIHa8VF0x5ZJtWXAFuEbDFZQB6TIuN/pubchart?oid=270505823&format=interactive",
  sheets_gid="1452747230",
  sql_file=""
  )
}}

Twitter meta tags once again follow the pattern of a general increase in usage, more specifically in the common tags of `twitter:card`, `twitter:title`, ` twitter:description` and `twitter:image`. A notable increase can be seen for `twitter:label1` and `twitter:data1`, both at 7% in 2021 to over 9% in 2022 for mobile pages.

{{ figure_markup(
  image="twitter-meta-tag-usage-by-year-mobile.png",
  caption="Twitter meta tag usage by year - Mobile",
  description="A year on year comparison of Twitter meta tag usage on mobile pages",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRr8oRb8NNs5MbpPpDi7QSsTUTPQL_vxQtQvmn52qGk97gpNhJIHa8VF0x5ZJtWXAFuEbDFZQB6TIuN/pubchart?oid=1993854314&format=interactive",
  sheets_gid="1452747230",
  sql_file=""
  )
}}

{{ figure_markup(
  image="twitter-meta-tag-usage-by-year-desktop.png",
  caption="Twitter meta tag usage by year - Desktop",
  description="A year on year comparison of Twitter meta tag usage on desktop pages",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRr8oRb8NNs5MbpPpDi7QSsTUTPQL_vxQtQvmn52qGk97gpNhJIHa8VF0x5ZJtWXAFuEbDFZQB6TIuN/pubchart?oid=2023017547&format=interactive",
  sheets_gid="1452747230",
  sql_file=""
  )
}}

Twitter meta tags such as `twitter:site` and `twitter:image` have a larger presence on desktop sites, though the majority of these meta tags share the same prevalence between mobile and desktop, as well as year-to-year. Some of the less common tags saw a slight decrease in use this year, though Twitter meta tag usage maintains an overall increase from last year.

### Facebook

{{ figure_markup(
  image="facebook-meta-tag-usage-by-year.png",
  caption="Facebook meta tag usage by year",
  description="A year on year comparison of facebook meta tag usage",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRr8oRb8NNs5MbpPpDi7QSsTUTPQL_vxQtQvmn52qGk97gpNhJIHa8VF0x5ZJtWXAFuEbDFZQB6TIuN/pubchart?oid=230494604&format=interactive",
  sheets_gid="1452747230",
  sql_file=""
  )
}}

Out of all of the Facebook tags here, there are only three with significant numbers of appearances. These are the same as the top three in 2021, namely `fb:app_id`, `fb:admins` and `fb:pages` at 5.75%, 2.57% and 0.79% on mobile, all a slight decrease from last year.

{{ figure_markup(
  image="facebook-meta-tag-usage-by-year-mobile.png",
  caption="Facebook meta tag usage by year - Mobile",
  description="A year on year comparison of Facebook meta tag usage on mobile pages",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRr8oRb8NNs5MbpPpDi7QSsTUTPQL_vxQtQvmn52qGk97gpNhJIHa8VF0x5ZJtWXAFuEbDFZQB6TIuN/pubchart?oid=978227692&format=interactive",
  sheets_gid="1452747230",
  sql_file=""
  )
}}

{{ figure_markup(
  image="facebook-meta-tag-usage-by-year-desktop.png",
  caption="Facebook meta tag usage by year - Desktop",
  description="A year on year comparison of facebook meta tag usage on desktop pages",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRr8oRb8NNs5MbpPpDi7QSsTUTPQL_vxQtQvmn52qGk97gpNhJIHa8VF0x5ZJtWXAFuEbDFZQB6TIuN/pubchart?oid=545166634&format=interactive",
  sheets_gid="1452747230",
  sql_file=""
  )
}}

This is true for desktop pages too, with the exception of `fb:pages` at a slight increase from 0.90% in 2021 to 0.92% in 2022. The meta tag `fb:pages_id` sees a slight increase on mobile and desktop pages alike, but overall facebook meta tag usage has seen a decline for both mobile and desktop pages since last year.

### Microformats and microformats2

{{ figure_markup(
  image="microformats-usage-by-year.png",
  caption="Microformats usage by year",
  description="A year on year comparison of microformats usage",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRr8oRb8NNs5MbpPpDi7QSsTUTPQL_vxQtQvmn52qGk97gpNhJIHa8VF0x5ZJtWXAFuEbDFZQB6TIuN/pubchart?oid=1952037124&format=interactive",
  sheets_gid="1452747230",
  sql_file=""
  )
}}

Microformats have remained very similar in usage numbers since 2021, with `adr` (appearing on 0.47% of pages in our set) still being the most common on the list.

{{ figure_markup(
  image="microformats-usage-by-year-mobile.png",
  caption="Microformats usage by year - Mobile",
  description="A year on year comparison of Microformats usage on mobile pages",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRr8oRb8NNs5MbpPpDi7QSsTUTPQL_vxQtQvmn52qGk97gpNhJIHa8VF0x5ZJtWXAFuEbDFZQB6TIuN/pubchart?oid=1161847910&format=interactive",
  sheets_gid="1452747230",
  sql_file=""
  )
}}

{{ figure_markup(
  image="microformats-usage-by-year-desktop.png",
  caption="Microformats usage by year - Desktop",
  description="A year on year comparison of Microformats usage on desktop pages",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRr8oRb8NNs5MbpPpDi7QSsTUTPQL_vxQtQvmn52qGk97gpNhJIHa8VF0x5ZJtWXAFuEbDFZQB6TIuN/pubchart?oid=63305043&format=interactive",
  sheets_gid="1452747230",
  sql_file=""
  )
}}

Both mobile and desktop share a mix of increased and decreased usage between microformat types, though both averaging out to less than last year’s numbers. Some types which factor into this decrease are `hReview` (going from 0.06% to 0.05% on mobile pages and 0.06% to 0.04% on desktop pages) and `hReview-aggregate` (going from 0.06% to 0.04% on both mobile and desktop pages).

{{ figure_markup(
  image="microformats2-usage-by-year.png",
  caption="Microformats2 usage by year",
  description="A year on year comparison of microformats2 usage",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRr8oRb8NNs5MbpPpDi7QSsTUTPQL_vxQtQvmn52qGk97gpNhJIHa8VF0x5ZJtWXAFuEbDFZQB6TIuN/pubchart?oid=392054831&format=interactive",
  sheets_gid="1452747230",
  sql_file=""
  )
}}

Meanwhile, microformats2 attributes have skyrocketed since 2021. The properties of `h-entry`, `h-card` and `h-feed` have shown huge increases in our set of pages, which account for the fact that microformats2 attributes have almost tripled in our set since the previous year.

{{ figure_markup(
  image="microformats2-usage-by-year-mobile.png",
  caption="Microformats2 usage by year - Mobile",
  description="A year on year comparison of Microformats2 usage on mobile pages",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRr8oRb8NNs5MbpPpDi7QSsTUTPQL_vxQtQvmn52qGk97gpNhJIHa8VF0x5ZJtWXAFuEbDFZQB6TIuN/pubchart?oid=392054831&format=interactive",
  sheets_gid="1452747230",
  sql_file=""
  )
}}

{{ figure_markup(
  image="microformats2 usage by year-desktop.png",
  caption="Microformats2 usage by year - Desktop",
  description="A year on year comparison of Microformats2 usage on desktop pages",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRr8oRb8NNs5MbpPpDi7QSsTUTPQL_vxQtQvmn52qGk97gpNhJIHa8VF0x5ZJtWXAFuEbDFZQB6TIuN/pubchart?oid=703299916&format=interactive",
  sheets_gid="1452747230",
  sql_file=""
  )
}}

This growth is seen more drastically on mobile pages, though desktop pages do follow the same pattern. Other than that, `h-adr` remains the exact same across both years and both platforms at 0.02% of pages.

### Microdata

{{ figure_markup(
  image="microdata-usage-by-year.png",
  caption="Microdata usage by year",
  description="A year on year comparison of microdata usage",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRr8oRb8NNs5MbpPpDi7QSsTUTPQL_vxQtQvmn52qGk97gpNhJIHa8VF0x5ZJtWXAFuEbDFZQB6TIuN/pubchart?oid=1132507895&format=interactive",
  sheets_gid="1452747230",
  sql_file=""
  )
}}

Most of the properties for Microdata have not seen much change, with a slight increase in some of the more common properties such as `webpage`, `sitenavigationelement` and `wpheader` appearing in 7.85%, 6.11% and 5.32% of mobile pages respectively.

{{ figure_markup(
  image="microdata-usage-by-year-mobile.png",
  caption="Microdata usage by year - Mobile",
  description="A year on year comparison of microdata usage on mobile pages",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRr8oRb8NNs5MbpPpDi7QSsTUTPQL_vxQtQvmn52qGk97gpNhJIHa8VF0x5ZJtWXAFuEbDFZQB6TIuN/pubchart?oid=1393933149&format=interactive",
  sheets_gid="1452747230",
  sql_file=""
  )
}}

{{ figure_markup(
  image="microdata-usage-by-year-desktop.png",
  caption="Microdata usage by year - Desktop",
  description="A year on year comparison of microdata usage on desktop pages",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRr8oRb8NNs5MbpPpDi7QSsTUTPQL_vxQtQvmn52qGk97gpNhJIHa8VF0x5ZJtWXAFuEbDFZQB6TIuN/pubchart?oid=567931548&format=interactive",
  sheets_gid="1452747230",
  sql_file=""
  )
}}

These increases are common for desktop as well, with slight decreases elsewhere such as `wpsidebar` (going from 1.38% to 1.17% on mobile pages and going from 1.25% to 1.08% on desktop pages), resulting in minimum change over the last year for both mobile and desktop pages as a whole.

### JSON-LD

{{ figure_markup(
  image="json-ld-usage-by-year.png",
  caption="JSON-LD usage by year",
  description="A year on year comparison of JSON-LD usage",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRr8oRb8NNs5MbpPpDi7QSsTUTPQL_vxQtQvmn52qGk97gpNhJIHa8VF0x5ZJtWXAFuEbDFZQB6TIuN/pubchart?oid=1274560821&format=interactive",
  sheets_gid="1452747230",
  sql_file=""
  )
}}

JSON-LD types continue to be mostly similar with a few notable increases over the previous year. Namely, these are `LocalBusiness` (which has increased to 2.75% of pages in our set) and `Restaurant`  (which has increased to 0.28% of pages in our set).

{{ figure_markup(
  image="json-ld-usage-by-year-mobile.png",
  caption="JSON-LD usage by year - Mobile",
  description="A year on year comparison of JSON-LD usage on mobile pages",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRr8oRb8NNs5MbpPpDi7QSsTUTPQL_vxQtQvmn52qGk97gpNhJIHa8VF0x5ZJtWXAFuEbDFZQB6TIuN/pubchart?oid=1634241816&format=interactive",
  sheets_gid="1452747230",
  sql_file=""
  )
}}

{{ figure_markup(
  image="json-ld-usage-by-year-desktop.png",
  caption="JSON-LD usage by year - Desktop",
  description="A year on year comparison of JSON-LD usage on desktop pages",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRr8oRb8NNs5MbpPpDi7QSsTUTPQL_vxQtQvmn52qGk97gpNhJIHa8VF0x5ZJtWXAFuEbDFZQB6TIuN/pubchart?oid=247275871&format=interactive",
  sheets_gid="1452747230",
  sql_file=""
  )
}}

These increases are enough to make JSON-LD types have the 2nd biggest positive change since 2021, going from appearing on 33.53% to 36.5% of mobile pages in our set and going from 34.1% to 36.86% on desktop pages.

### `SameAs`

{{ figure_markup(
  image="sameas-usage-by-year.png",
  caption="`SameAs` usage by year",
  description="A year on year comparison of `SameAs` usage",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRr8oRb8NNs5MbpPpDi7QSsTUTPQL_vxQtQvmn52qGk97gpNhJIHa8VF0x5ZJtWXAFuEbDFZQB6TIuN/pubchart?oid=30131405&format=interactive",
  sheets_gid="1452747230",
  sql_file=""
  )
}}

As was the case in 2021, the most common values of the `sameAs` property are social media platforms. These include facebook.com (at 4.32% on mobile and 4.94% on desktop), instagram.com (at 2.93% on mobile and 3.34% on desktop) and twitter.com (at 2.30% on mobile and 2.86% on desktop). The former two of which have seen a slight increase on mobile from 2021, with all 3 increasing on desktop.

{{ figure_markup(
  image="sameas-usage-by-year-mobile.png",
  caption="SameAs usage by year - Mobile",
  description="A year on year comparison of SameAs usage on mobile pages",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRr8oRb8NNs5MbpPpDi7QSsTUTPQL_vxQtQvmn52qGk97gpNhJIHa8VF0x5ZJtWXAFuEbDFZQB6TIuN/pubchart?oid=1443969983&format=interactive",
  sheets_gid="1452747230",
  sql_file=""
  )
}}

{{ figure_markup(
  image="sameas-usage-by-year-desktop.png",
  caption="SameAs usage by year - Desktop",
  description="A year on year comparison of SameAs usage on desktop pages",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRr8oRb8NNs5MbpPpDi7QSsTUTPQL_vxQtQvmn52qGk97gpNhJIHa8VF0x5ZJtWXAFuEbDFZQB6TIuN/pubchart?oid=1080428439&format=interactive",
  sheets_gid="1452747230",
  sql_file=""
  )
}}

The rest of the list includes information sources such as wikipedia.org (at 0.13% on both mobile and desktop) and yelp.com (at 0.11% on mobile and 0.13% on desktop), both at an increase from the previous year.

### Further year on year insight - relative changes

{{ figure_markup(
  image="sameas-relative-change.png",
  caption="SameAs relative change",
  description="The relative % of the top SameAs entries between 2021 and 2022",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRr8oRb8NNs5MbpPpDi7QSsTUTPQL_vxQtQvmn52qGk97gpNhJIHa8VF0x5ZJtWXAFuEbDFZQB6TIuN/pubchart?oid=1046677446&format=interactive",
  sheets_gid="1452747230",
  sql_file=""
  )
}}

It is insightful to look at the SameAs entries and how they change over time. TikTok has seen a huge increase with 2022 showing its appearance on six times as many pages relative to our set compared to 2021. This change is equal for both desktop and mobile pages. Pinterest, and the various domain names it has, make up for 3 of the top 5 largest growth for mobile pages in 2022. Mobile overall has seen a larger increase for SameAs entries than desktop, with Spotify being an exception with its desktop page appearances being doubled compared to 2021.

{{ figure_markup(
  image="sameas-domain-average-relative-change.png",
  caption="SameAs domain average relative change",
  description="The average relative change for SameAs entries, grouped by domain",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRr8oRb8NNs5MbpPpDi7QSsTUTPQL_vxQtQvmn52qGk97gpNhJIHa8VF0x5ZJtWXAFuEbDFZQB6TIuN/pubchart?oid=1247757269&format=interactive",
  sheets_gid="1452747230",
  sql_file=""
  )
}}

Looking at the domain names of the SameAs entries, and how they change over time, also may give valuable insight. In the largest desktop page growth we see .ca, .net and .fr, with the latter also being up there in the top for mobile page increases. As this is an average, the amount of entries is not accounted for. In both years .com is far larger in numbers than all other entries, but the average change is 125% for mobile pages and 117% for desktop pages. The Canadian and French domain averages are heavily boosted by Pinterest, which (as mentioned above) has seen widespread increases from last year. In fact, 7 out of the top 10 SameAs domain growers have Pinterest in their entries, sometimes being their only entry.

{{ figure_markup(
  image="json-ld-contexts-relative-change.png",
  caption="JSON-LD contexts relative change",
  description="The relative change of JSON-LD contexts between 2021 and 2022",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRr8oRb8NNs5MbpPpDi7QSsTUTPQL_vxQtQvmn52qGk97gpNhJIHa8VF0x5ZJtWXAFuEbDFZQB6TIuN/pubchart?oid=1092709727&format=interactive",
  sheets_gid="1452747230",
  sql_file=""
  )
}}

For JSON-LD contexts, schema.org is by far the largest contributor, with over 6000 times as many appearances for desktop pages and over 3500 times as many appearances for mobile pages than the second largest contributor, googleapis.com. With that said, googleapis.com’s appearances more than doubled for both desktop and mobile pages, compared to schema.org’s more modest increase to 108% of last year’s numbers. In terms of top growers, contao.org and rich-snippets.io take the top spots with contao.org’s desktop page increase of 819% and rich-snippets.io’s mobile increase of 849%. Contao.org ranks 4th in total entries, while rich-snippets.io ranks at 8th.

## Use Cases

### Structured data consumers

The implementation of structured data is widely beneficial in numerous areas, some of which will be focused on in this section. It is important to note that many of these areas are overlapping, such is the nature of linked and structured data.

#### Data linking

Having structured and linked data, while using identifiers to designate places, events, people, concepts, etc, the data can be cited by other data sources and therefore make their metadata descriptions more accessible. This data is then more sharable and reusable.

With data linking, we collect information from different sources to create richer and more useful data. This is possible thanks to structured data, whose global, unique identifiers allow machines to read and understand the relationship between different types of data. This has the use of creating a more connected web of relationships.

#### Search Engine Optimization & discoverability

Search engine optimization (<a hreflang="en" href="https://www.webopedia.com/definitions/seo/#How_does_SEO_work">SEO</a>) is the area focusing on building the content of a web page so that it has better results from search engines. Naturally, this is highly important for discoverability as a successful implementation of SEO may allow for a page to appear higher on the search engine results page (<a hreflang="en" href="https://www.webopedia.com/definitions/serp/">SERP</a>). The SERP is where the titles, URLs, and meta descriptions are displayed from a search query.

By adding structured data to web pages, we can optimize a web page for search engines, as well as have extra content visible from the SERP. This extra content can come in many forms, some of which has been [discussed previously](#heading=h.pun7uv6k8bah), namely Knowledge Panels, Rich Snippets and Related Questions.

Having this added discoverability, enabled by structured data, is essential for increasing traffic to a web page from search engines. It follows that businesses and eCommerce pages would find great value in these technologies, which will be discussed in the following section.

#### eCommerce & Business

The implementation of structured data for eCommerce web pages is incredibly beneficial for those involved with the business. There are numerous structured data types which are widely used for these businesses for SEO.

<a hreflang="en" href="https://developers.google.com/search/docs/advanced/structured-data/local-business">LocalBusiness </a>is a structured data type which may return a Google knowledge panel with details entered in the structured data type during relevant search queries (e.g. “popular restaurants in Dublin”). This type also may have business hours, different departments within a business, reviews for the business, which could all be returned from a maps app search query as well.

<a hreflang="en" href="https://developers.google.com/search/docs/advanced/structured-data/product">Product</a>, the structured data type, works similarly to LocalBusiness in that it allows for a search query to return rich results. These results can include price, availability, reviews, ratings, and even images in the search results. These added elements can make the product far more likely to receive attention from the search. Product attributes can help link products together and better respond to search queries, increasing discoverability.

These are just a couple of examples of use cases for structured data in ecommerce, but there are many <a hreflang="en" href="https://developers.google.com/search/docs/advanced/ecommerce/include-structured-data-relevant-to-ecommerce">more structured data types</a> that an ecommerce page can benefit from implementing.

## Conclusion

A lot has been outlined about how the technologies, ideas, and benefits of structured data affect the web, and by extension, our experience on the web. With the key concepts outlined, we have been able to look at the data in comparison to the Web Almanac 2021’s chapter on structured data, in which we have seen a  general increase in these widely-used structured data types, while there is a slight decrease in usage for some of the less prevalent structured data types.

In this chapter, there has been an outline of some of the benefits of using structured data in web pages. Although far from a comprehensive list, structured and linked data give many advantages to:

- eCommerce pages
- Business pages
- Researchers
- Social media sites
- Users

through SEO, increased discoverability, general data linking and rich results. These technologies, and their growing implementation within web pages, result in a more connected and accessible web.

With more information and insight available than ever before, it is important to understand the capabilities and limitations of certain techniques or choices when trying to increase web page traffic. Adding fake reviews or misleading data in the hopes of successful SEO can and will be detected, resulting in fewer benefits from those mentioned above, as well as poorer discoverability and performance from search engines.

Although this is the second year in which this chapter has featured in the Web Almanac, we are excited to see how these trends continue and change, along with the state of structured data on the web. We are looking to see increased widespread implementation of these technologies, with all of the benefits they bring.
