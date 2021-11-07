---
#See https://github.com/HTTPArchive/almanac.httparchive.org/wiki/Authors'-Guide#metadata-to-add-at-the-top-of-your-chapters
title: CSS
description: TODO
authors: []
reviewers: []
analysts: []
editors: []
translators: []
results: https://docs.google.com/spreadsheets/d/12vQIA0xsC5Jr3J9Sh03AcAvgFjMAmP1xSS6Tjai9LF0/
featured_quote: TODO
featured_stat_1: TODO
featured_stat_label_1: TODO
featured_stat_2: TODO
featured_stat_label_2: TODO
featured_stat_3: TODO
featured_stat_label_3: TODO
---

## TODO



{{ figure_markup(
  image="stylesheet-transfer-size.png",
  caption="Distribution of stylesheet transfer sizes per page.",
  description="TODO",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRXMwdR5iy0KEMBzUWuZqDfWsj8HDDJcd5lFfjJpBmJr8gI1TE3xz2BzbNB9SEzSrxDtxfqvDvnvbQ3/pubchart?oid=900703452&format=interactive",
  sheets_gid="350963758",
  sql_file="stylesheet_kbytes.sql"
) }}



<figure>
  <table>
    <thead>
      <tr>
        <th>Sourcemap type</th>
        <th>2020</th>
        <th>2021</th>
      </tr>
    </thead>
    <tbody>
      <tr>
        <td>CSS files</td>
        <td class="numeric">45%</td>
        <td class="numeric">45%</td>
      </tr>
      <tr>
        <td>Sass</td>
        <td class="numeric">34%</td>
        <td class="numeric">37%</td>
      </tr>
      <tr>
        <td>Less</td>
        <td class="numeric">21%</td>
        <td class="numeric">17%</td>
      </tr>
    </tbody>
  </table>
  <figcaption>{{ figure_link(
    caption="Sourcemap types in 2021 versus 2020.",
    sheets_gid="945827671",
    sql_file="sourcemap_adoption.sql"
  ) }}</figcaption>
</figure>



{{ figure_markup(
  image="stylesheets-per-page.png",
  caption="Distribution of the number of stylesheets per page.",
  description="TODO",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRXMwdR5iy0KEMBzUWuZqDfWsj8HDDJcd5lFfjJpBmJr8gI1TE3xz2BzbNB9SEzSrxDtxfqvDvnvbQ3/pubchart?oid=1775427809&format=interactive",
  sheets_gid="751625680",
  sql_file="stylesheet_count.sql"
) }}



{{ figure_markup(
  caption="The largest number of external stylesheets loaded by a page.",
  content="2,368",
  classes="big-number",
  sheets_gid="751625680",
  sql_file="stylesheet_count.sql"
) }}



{{ figure_markup(
  image="rules-per-page.png",
  caption="Distribution of the total number of style rules per page.",
  description="TODO",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRXMwdR5iy0KEMBzUWuZqDfWsj8HDDJcd5lFfjJpBmJr8gI1TE3xz2BzbNB9SEzSrxDtxfqvDvnvbQ3/pubchart?oid=472863207&format=interactive",
  sheets_gid="697775839",
  sql_file="selectors.sql"
) }}



{{ figure_markup(
  image="most-popular-class-names.png",
  caption="The most popular class names.",
  description="TODO",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRXMwdR5iy0KEMBzUWuZqDfWsj8HDDJcd5lFfjJpBmJr8gI1TE3xz2BzbNB9SEzSrxDtxfqvDvnvbQ3/pubchart?oid=1533988979&format=interactive",
  width=600,
  height=691,
  sheets_gid="982850647",
  sql_file="top_selector_classes_wp_fa_prefixes.sql"
) }}



{{ figure_markup(
  image="most-popular-id-names.png",
  caption="The most popular ID names.",
  description="TODO",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRXMwdR5iy0KEMBzUWuZqDfWsj8HDDJcd5lFfjJpBmJr8gI1TE3xz2BzbNB9SEzSrxDtxfqvDvnvbQ3/pubchart?oid=609865919&format=interactive",
  width=600,
  height=497,
  sheets_gid="289906540",
  sql_file="top_selector_ids.sql"
) }}



{{ figure_markup(
  image="most-popular-attribute-selectors.png",
  caption="The most popular attribute selectors.",
  description="TODO",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRXMwdR5iy0KEMBzUWuZqDfWsj8HDDJcd5lFfjJpBmJr8gI1TE3xz2BzbNB9SEzSrxDtxfqvDvnvbQ3/pubchart?oid=1836678858&format=interactive",
  sheets_gid="942534767",
  sql_file="top_selector_attributes.sql"
) }}



{{ figure_markup(
  image="most-popular-pseudo-classes.png",
  caption="The most popular pseudo-classes.",
  description="TODO",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRXMwdR5iy0KEMBzUWuZqDfWsj8HDDJcd5lFfjJpBmJr8gI1TE3xz2BzbNB9SEzSrxDtxfqvDvnvbQ3/pubchart?oid=1619223389&format=interactive",
  sheets_gid="843054585",
  sql_file="top_selector_pseudo_classes.sql"
) }}



{{ figure_markup(
  image="most-popular-unprefixed-pseudo-elements.png",
  caption="The most popular unprefixed pseudo-elements.",
  description="TODO",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRXMwdR5iy0KEMBzUWuZqDfWsj8HDDJcd5lFfjJpBmJr8gI1TE3xz2BzbNB9SEzSrxDtxfqvDvnvbQ3/pubchart?oid=1825062416&format=interactive",
  height=500,
  sheets_gid="1863963291",
  sql_file="top_selector_pseudo_elements.sql"
) }}
