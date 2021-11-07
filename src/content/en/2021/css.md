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
  caption="Distribution of the median stylesheet transfer size per page.",
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
