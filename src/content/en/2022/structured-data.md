---
#See https://github.com/HTTPArchive/almanac.httparchive.org/wiki/Authors'-Guide#metadata-to-add-at-the-top-of-your-chapters
title: Structured Data
#TODO - Review and update chapter description
description: Structured Data chapter of the 2022 Web Almanac covering adoption and impact of schema.org, RDFa, Microdata and more.
authors: [cyberandy, DataBytzAI]
reviewers: [SeoRobt, jonoalderson]
analysts: [rviscomi]
editors: [JasmineDW]
translators: []
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

## TODO

{{ figure_markup(
  image="sankey.png",
  caption="Sankey Chart.",
  description='Sankey chart showing...',
  chart_url="/en/2022/embeds/structured-data-sankey",
  width=600,
  height=1200,
  sheets_gid="??",
  sql_file="??.sql"
  )
}}

{{ figure_markup(
  image="structured-data-json-ld-entities-relationships.svg",
  caption="JSON-LD entity relationship as a Sankey diagram.",
  description='Sankey diagram showing a complex interweaving of relationships of the form: "From" -> "Relationship" -> "To". `WebPage` is the largest "From" item branching off to multiple "Relationship" types and "To" results (for example `WebPage` -> `PotentialAction` -> `SearchAction`). This is followed by `WebSite`, then `Organization`, `Product`, `BreadCrumblist`, `BlogPosting` and then a decreasingly used list of other items. Of the middle "Relationships" column `PotentialAction` is used most, followed by `ItemListElement`, `IsPartOf`, `Publisher`, `image` and then a similar long tail of ever-decreasing usage. The "To" column has `ImageObject` as the most used at the top, following by `Organization`, `SearchAction`, `ListItem`, `WebSite`, `WebPage` and then again a longer tail of every decreasing usage. The general sense created by the graph is a lot of different relationships with much cross-usage between the three columns.',
  width=1200,
  height=1200
  )
}}

{{ figure_markup(
  image="structured-data-relationships-sankey.png",
  caption="Sankey Chart.",
  description='Sankey chart showing...',
  chart_url="/en/2022/embeds/structured-data-relationships-sankey",
  width=600,
  height=1200,
  sheets_gid="??",
  sql_file="??.sql"
  )
}}
