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



{{ figure_markup(
  image="important-properties-per-page.png",
  caption="Distribution of the percentage of page rules using `!important`.",
  description="TODO",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRXMwdR5iy0KEMBzUWuZqDfWsj8HDDJcd5lFfjJpBmJr8gI1TE3xz2BzbNB9SEzSrxDtxfqvDvnvbQ3/pubchart?oid=1184051032&format=interactive",
  sheets_gid="1176732383",
  sql_file="meta_important_adoption.sql"
) }}



{{ figure_markup(
  image="top-important-properties.png",
  caption="The most popular properties targeted by `!important`.",
  description="TODO",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRXMwdR5iy0KEMBzUWuZqDfWsj8HDDJcd5lFfjJpBmJr8gI1TE3xz2BzbNB9SEzSrxDtxfqvDvnvbQ3/pubchart?oid=905910904&format=interactive",
  sheets_gid="1381789151",
  sql_file="meta_important_properties.sql"
) }}



<figure>
  <table>
    <thead>
      <tr>
        <th>Percentile</th>
        <th>Desktop</th>
        <th>Mobile</th>
    </tr>
    </thead>
    <tbody>
      <tr>
        <th>10</th>
        <td>0,1,0</td>
        <td>0,1,0</td>
      </tr>
      <tr>
        <th>25</th>
        <td>0,2,0</td>
        <td>0,1,3 (up 0,0,1)</td>
      </tr>
      <tr>
        <th>50</th>
        <td>0,2,0</td>
        <td>0,2,0</td>
      </tr>
      <tr>
        <th>75</th>
        <td>0,2,0</td>
        <td>0,2,0</td>
      </tr>
      <tr>
        <th>90</th>
        <td>0,3,0</td>
        <td>0,3,0</td>
      </tr>
    </tbody>
  </table>
  <figcaption>{{ figure_link(
    caption="Distribution of the median selector specificity per page.",
    sheets_gid="1962870115",
    sql_file="specificity.sql"
  ) }}</figcaption>
</figure>



{{ figure_markup(
  image="most-popular-length-units.png",
  caption="The most popular length units.",
  description="TODO",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRXMwdR5iy0KEMBzUWuZqDfWsj8HDDJcd5lFfjJpBmJr8gI1TE3xz2BzbNB9SEzSrxDtxfqvDvnvbQ3/pubchart?oid=1920968690&format=interactive",
  sheets_gid="529909801",
  sql_file="units_frequency.sql"
) }}



<figure>
  <table>
    <thead>
      <tr>
        <th>Property</th>
        <th>px</th>
        <th>&lt;number&gt;</th>
        <th>em</th>
        <th>%</th>
        <th>rem</th>
        <th>pt</th>
      </tr>
    </thead>
    <tbody>
      <tr>
        <td>font-size</td>
        <td class="numeric"><span class="numeric-bad">(▼1%)</span> 69%</td>
        <td class="numeric">2%</td>
        <td class="numeric"><span class="numeric-bad">(▼1%)</span> 16%</td>
        <td class="numeric"><span class="numeric-bad">(▼1%)</span> 5%</td>
        <td class="numeric"><span class="numeric-good">(▲1%)</span> 5%</td>
        <td class="numeric">2%</td>
      </tr>
      <tr>
        <td>line-height</td>
        <td class="numeric"><span class="numeric-bad">(▼5%)</span> 49%</td>
        <td class="numeric"><span class="numeric-good">(▲3%)</span> 34%</td>
        <td class="numeric"><span class="numeric-good">(▲1%)</span> 14%</td>
        <td class="numeric"><span class="numeric-bad">(▼1%)</span> 2%</td>
        <td class="numeric"><span class="numeric-good">(▲1%)</span> 1%</td>
        <td class="numeric">0%</td>
      </tr>
      <tr>
        <td>border-radius</td>
        <td class="numeric">65%</td>
        <td class="numeric"><span class="numeric-bad">(▼1%)</span> 20%</td>
        <td class="numeric">3%</td>
        <td class="numeric">10%</td>
        <td class="numeric"><span class="numeric-good">(▲2%)</span> 2%</td>
        <td class="numeric">0%</td>
      </tr>
      <tr>
        <td>border</td>
        <td class="numeric">71%</td>
        <td class="numeric"><span class="numeric-good">(▲1%)</span> 28%</td>
        <td class="numeric">2%</td>
        <td class="numeric">0%</td>
        <td class="numeric">0%</td>
        <td class="numeric">0%</td>
      </tr>
      <tr>
        <td>text-indent</td>
        <td class="numeric"><span class="numeric-bad">(▼1%)</span> 31%</td>
        <td class="numeric"><span class="numeric-good">(▲1%)</span> 52%</td>
        <td class="numeric">8%</td>
        <td class="numeric"><span class="numeric-bad">(▼1%)</span> 8%</td>
        <td class="numeric">0%</td>
        <td class="numeric">0%</td>
      </tr>
      <tr>
        <td>gap</td>
        <td class="numeric"><span class="numeric-bad">(▼8%)</span> 13%</td>
        <td class="numeric"><span class="numeric-good">(▲2%)</span> 18%</td>
        <td class="numeric"><span class="numeric-bad">(▼1%)</span> 0%</td>
        <td class="numeric">0%</td>
        <td class="numeric"><span class="numeric-good">(▲7%)</span> 69%</td>
        <td class="numeric">0%</td>
      </tr>
      <tr>
        <td>vertical-align</td>
        <td class="numeric"><span class="numeric-bad">(▼11%)</span> 18%</td>
        <td class="numeric">12%</td>
        <td class="numeric"><span class="numeric-good">(▲11%)</span> 66%</td>
        <td class="numeric">4%</td>
        <td class="numeric">0%</td>
        <td class="numeric">0%</td>
      </tr>
      <tr>
        <td>grid-gap</td>
        <td class="numeric"><span class="numeric-good">(▲3%)</span> 66%</td>
        <td class="numeric"><span class="numeric-bad">(▼1%)</span> 10%</td>
        <td class="numeric">9%</td>
        <td class="numeric"><span class="numeric-bad">(▼1%)</span> 0%</td>
        <td class="numeric"><span class="numeric-bad">(▼2%)</span> 14%</td>
        <td class="numeric">0%</td>
      </tr>
      <tr>
        <td>padding-inline-start</td>
        <td class="numeric"><span class="numeric-bad">(▼7%)</span> 26%</td>
        <td class="numeric"><span class="numeric-good">(▲2%)</span> 7%</td>
        <td class="numeric"><span class="numeric-good">(▲4%)</span> 66%</td>
        <td class="numeric">0%</td>
        <td class="numeric">0%</td>
        <td class="numeric">0%</td>
      </tr>
      <tr>
        <td>mask-position</td>
        <td class="numeric">0%</td>
        <td class="numeric">0%</td>
        <td class="numeric"><span class="numeric-bad">(▼1%)</span> 49%</td>
        <td class="numeric"><span class="numeric-good">(▲1%)</span> 51%</td>
        <td class="numeric">0%</td>
        <td class="numeric">0%</td>
      </tr>
      <tr>
        <td>margin-inline-start</td>
        <td class="numeric"><span class="numeric-bad">(▼7%)</span> 31%</td>
        <td class="numeric"><span class="numeric-good">(▲5%)</span> 51%</td>
        <td class="numeric"><span class="numeric-good">(▲1%)</span> 15%</td>
        <td class="numeric"><span class="numeric-good">(▲2%)</span> 2%</td>
        <td class="numeric">1%</td>
        <td class="numeric">0%</td>
      </tr>
      <tr>
        <td>margin-block-end</td>
        <td class="numeric"><span class="numeric-good">(▲1%)</span> 5%</td>
        <td class="numeric"><span class="numeric-good">(▲7%)</span> 38%</td>
        <td class="numeric"><span class="numeric-bad">(▼9%)</span> 56%</td>
        <td class="numeric">0%</td>
        <td class="numeric"><span class="numeric-good">(▲1%)</span> 1%</td>
        <td class="numeric">0%</td>
      </tr>
    </tbody>
  </table>
  <figcaption>{{ figure_link(
    caption="Distribution of length types per property.",
    sheets_gid="2127104776",
    sql_file="units_properties.sql"
  ) }}</figcaption>
</figure>



{{ figure_markup(
  image="most-popular-font-relative-units-of-length.png",
  caption="The most popular font-relative length units.",
  description="TODO",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRXMwdR5iy0KEMBzUWuZqDfWsj8HDDJcd5lFfjJpBmJr8gI1TE3xz2BzbNB9SEzSrxDtxfqvDvnvbQ3/pubchart?oid=658259611&format=interactive",
  sheets_gid="529909801",
  sql_file="units_properties.sql"
) }}



{{ figure_markup(
  image="zero-lengths-by-unit.png",
  caption="The units (or lack thereof) used on zero-length values.",
  description="TODO",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRXMwdR5iy0KEMBzUWuZqDfWsj8HDDJcd5lFfjJpBmJr8gI1TE3xz2BzbNB9SEzSrxDtxfqvDvnvbQ3/pubchart?oid=758334535&format=interactive",
  sheets_gid="2139699206",
  sql_file="units_zero.sql"
) }}



{{ figure_markup(
  image="most-popular-properties-using-calc.png",
  caption="The most popular properties using `calc()` functions.",
  description="TODO",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRXMwdR5iy0KEMBzUWuZqDfWsj8HDDJcd5lFfjJpBmJr8gI1TE3xz2BzbNB9SEzSrxDtxfqvDvnvbQ3/pubchart?oid=907378413&format=interactive",
  sheets_gid="212269204",
  sql_file="calc_properties.sql"
) }}



{{ figure_markup(
  image="most-popular-units-using-calc.png",
  caption="The most popular length units used in `calc()` functions.",
  description="TODO",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRXMwdR5iy0KEMBzUWuZqDfWsj8HDDJcd5lFfjJpBmJr8gI1TE3xz2BzbNB9SEzSrxDtxfqvDvnvbQ3/pubchart?oid=833777702&format=interactive",
  sheets_gid="605954740",
  sql_file="calc_units.sql"
) }}



{{ figure_markup(
  image="most-popular-operators-using-calc.png",
  caption="The most popular operators used in `calc()` functions.",
  description="TODO",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRXMwdR5iy0KEMBzUWuZqDfWsj8HDDJcd5lFfjJpBmJr8gI1TE3xz2BzbNB9SEzSrxDtxfqvDvnvbQ3/pubchart?oid=1708226150&format=interactive",
  sheets_gid="464539022",
  sql_file="calc_operators.sql"
) }}



{{ figure_markup(
  image="units-per-calc-occurence.png",
  caption="The number of unique units used in `calc()` functions.",
  description="TODO",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRXMwdR5iy0KEMBzUWuZqDfWsj8HDDJcd5lFfjJpBmJr8gI1TE3xz2BzbNB9SEzSrxDtxfqvDvnvbQ3/pubchart?oid=276182784&format=interactive",
  sheets_gid="856430777",
  sql_file="calc_complexity_units.sql"
) }}



{{ figure_markup(
  image="global-keyword-adoption.png",
  caption="Usage of global keyword values.",
  description="TODO",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRXMwdR5iy0KEMBzUWuZqDfWsj8HDDJcd5lFfjJpBmJr8gI1TE3xz2BzbNB9SEzSrxDtxfqvDvnvbQ3/pubchart?oid=884074059&format=interactive",
  sheets_gid="731307554",
  sql_file="keyword_totals.sql"
) }}



{{ figure_markup(
  image="most-popular-color-formats.png",
  caption="The most popular color value formats.",
  description="TODO",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRXMwdR5iy0KEMBzUWuZqDfWsj8HDDJcd5lFfjJpBmJr8gI1TE3xz2BzbNB9SEzSrxDtxfqvDvnvbQ3/pubchart?oid=936970618&format=interactive",
  sheets_gid="2108707108",
  sql_file="color_formats.sql"
) }}



<figure>
  <table>
    <thead>
      <tr>
        <th>keyword</th>
        <th>desktop</th>
        <th>mobile</th>
      </tr>
    </thead>
    <tbody>
      <tr>
        <td>transparent</td>
        <td class="numeric">82.24%</td>
        <td class="numeric">82.93%</td>
      </tr>
      <tr>
        <td>white</td>
        <td class="numeric">7.97%</td>
        <td class="numeric">7.59%</td>
      </tr>
      <tr>
        <td>black</td>
        <td class="numeric">2.44%</td>
        <td class="numeric">2.29%</td>
      </tr>
      <tr>
        <td>red</td>
        <td class="numeric">2.23%</td>
        <td class="numeric">2.17%</td>
      </tr>
      <tr>
        <td>currentColor</td>
        <td class="numeric">1.94%</td>
        <td class="numeric">2.03%</td>
      </tr>
      <tr>
        <td>gray</td>
        <td class="numeric">0.68%</td>
        <td class="numeric">0.64%</td>
      </tr>
      <tr>
        <td>silver</td>
        <td class="numeric">0.56%</td>
        <td class="numeric">0.55%</td>
      </tr>
      <tr>
        <td>grey</td>
        <td class="numeric">0.39%</td>
        <td class="numeric">0.37%</td>
      </tr>
      <tr>
        <td>green</td>
        <td class="numeric">0.32%</td>
        <td class="numeric">0.31%</td>
      </tr>
      <tr>
        <td>blue</td>
        <td class="numeric">0.15%</td>
        <td class="numeric">0.12%</td>
      </tr>
      <tr>
        <td>whitesmoke</td>
        <td class="numeric">0.12%</td>
        <td class="numeric">0.11%</td>
      </tr>
      <tr>
        <td>orange</td>
        <td class="numeric">0.12%</td>
        <td class="numeric">0.10%</td>
      </tr>
      <tr>
        <td>lightgray</td>
        <td class="numeric">0.08%</td>
        <td class="numeric">0.08%</td>
      </tr>
      <tr>
        <td>lightgrey</td>
        <td class="numeric">0.07%</td>
        <td class="numeric">0.07%</td>
      </tr>
      <tr>
        <td>yellow</td>
        <td class="numeric">0.07%</td>
        <td class="numeric">0.06%</td>
      </tr>
      <tr>
        <td>gold</td>
        <td class="numeric">0.04%</td>
        <td class="numeric">0.03%</td>
      </tr>
      <tr>
        <td>magenta</td>
        <td class="numeric">0.03%</td>
        <td class="numeric">0.03%</td>
      </tr>
      <tr>
        <td>Background</td>
        <td class="numeric">0.02%</td>
        <td class="numeric">0.03%</td>
      </tr>
      <tr>
        <td>Highlight</td>
        <td class="numeric">0.02%</td>
        <td class="numeric">0.03%</td>
      </tr>
      <tr>
        <td>pink</td>
        <td class="numeric">0.03%</td>
        <td class="numeric">0.03%</td>
      </tr>
    </tbody>
  </table>
  <figcaption>{{ figure_link(
    caption="The most popular named-color keyword values.",
    sheets_gid="2107615938",
    sql_file="color_keywords.sql"
  ) }}</figcaption>
</figure>



{{ figure_markup(
  image="css-initiated-image-formats.png",
  caption="Distribution of the formats of external images loaded via CSS.",
  description="TODO",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRXMwdR5iy0KEMBzUWuZqDfWsj8HDDJcd5lFfjJpBmJr8gI1TE3xz2BzbNB9SEzSrxDtxfqvDvnvbQ3/pubchart?oid=868556131&format=interactive",
  sheets_gid="1133067574",
  sql_file="image_formats.sql"
) }}



{{ figure_markup(
  image="number-of-images-loaded.png",
  caption="Distribution of the number of external images loaded via CSS.",
  description="TODO",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRXMwdR5iy0KEMBzUWuZqDfWsj8HDDJcd5lFfjJpBmJr8gI1TE3xz2BzbNB9SEzSrxDtxfqvDvnvbQ3/pubchart?oid=1206209320&format=interactive",
  sheets_gid="361647805",
  sql_file="image_weights.sql"
) }}



{{ figure_markup(
  image="total-image-weight.png",
  caption="Distribution of the total weight in KB of external images loaded via CSS.",
  description="TODO",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRXMwdR5iy0KEMBzUWuZqDfWsj8HDDJcd5lFfjJpBmJr8gI1TE3xz2BzbNB9SEzSrxDtxfqvDvnvbQ3/pubchart?oid=1022255274&format=interactive",
  sheets_gid="361647805",
  sql_file="image_weights.sql"
) }}



<figure>
  <table>
    <thead>
      <tr>
        <th>percentile</th>
        <th>JPG</th>
        <th>PNG</th>
        <th>GIF</th>
        <th>(other)</th>
        <th>SVG</th>
        <th>WebP</th>
      </tr>
    </thead>
    <tbody>
      <tr>
        <td>10</td>
        <td class="numeric">4.5</td>
        <td class="numeric">0.7</td>
        <td class="numeric">0.5</td>
        <td class="numeric">0.3</td>
        <td class="numeric">0.4</td>
        <td class="numeric">1.7</td>
      </tr>
      <tr>
        <td>25</td>
        <td class="numeric">28.2</td>
        <td class="numeric">2.2</td>
        <td class="numeric">1.7</td>
        <td class="numeric">0.3</td>
        <td class="numeric">0.6</td>
        <td class="numeric">14.2</td>
      </tr>
      <tr>
        <td>50</td>
        <td class="numeric">114.3</td>
        <td class="numeric">7.0</td>
        <td class="numeric">3.7</td>
        <td class="numeric">0.3</td>
        <td class="numeric">1.7</td>
        <td class="numeric">39.6</td>
      </tr>
      <tr>
        <td>75</td>
        <td class="numeric">350.7</td>
        <td class="numeric">36.4</td>
        <td class="numeric">8.3</td>
        <td class="numeric">48.1</td>
        <td class="numeric">5.4</td>
        <td class="numeric">133.9</td>
      </tr>
      <tr>
        <td>90</td>
        <td class="numeric">889.3</td>
        <td class="numeric">173.6</td>
        <td class="numeric">13.0</td>
        <td class="numeric">229.2</td>
        <td class="numeric">20.0</td>
        <td class="numeric">361.8</td>
      </tr>
    </tbody>
  </table>
  <figcaption>{{ figure_link(
    caption="Distribution of the total weight in KB of external images loaded via CSS on mobile pages, by image format.",
    sheets_gid="1175815151",
    sql_file="image_weights_by_type.sql"
  ) }}</figcaption>
</figure>



<figure>
  <table>
    <thead>
      <tr>
        <th>Property</th>
        <th>Desktop</th>
        <th>Mobile</th>
      </tr>
    </thead>
    <tbody>
      <tr>
        <td>background</td>
        <td class="numeric">62%</td>
        <td class="numeric">62%</td>
      </tr>
      <tr>
        <td>background-image</td>
        <td class="numeric">62%</td>
        <td class="numeric">61%</td>
      </tr>
      <tr>
        <td>-webkit-mask-image</td>
        <td class="numeric">5%</td>
        <td class="numeric">5%</td>
      </tr>
      <tr>
        <td>&#8209;&#8209;*</td>
        <td class="numeric">1%</td>
        <td class="numeric">1%</td>
      </tr>
      <tr>
        <td>mask-image</td>
        <td class="numeric">1%</td>
        <td class="numeric">1%</td>
      </tr>
      <tr>
        <td>border-image</td>
        <td class="numeric">1%</td>
        <td class="numeric">1%</td>
      </tr>
    </tbody>
  </table>
  <figcaption>{{ figure_link(
    caption="Percentage of properties given gradient image values.",
    sheets_gid="204136042",
    sql_file="gradient_properties.sql"
  ) }}</figcaption>
</figure>



{{ figure_markup(
  image="most-popular-unprefixed-gradient-functions.png",
  caption="The most popular types of gradient image values.",
  description="TODO",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRXMwdR5iy0KEMBzUWuZqDfWsj8HDDJcd5lFfjJpBmJr8gI1TE3xz2BzbNB9SEzSrxDtxfqvDvnvbQ3/pubchart?oid=2004838082&format=interactive",
  sheets_gid="1135532290",
  sql_file="gradient_functions.sql"
) }}



{{ figure_markup(
  image="most-color-stops.png",
  classes="height-16vw-122px",
  caption="The linear gradient with the most color stops.",
  description="A screenshot of the gradient with the most color stops, which is a series of intricate multicolor stripes of varying hues.",
  width=600,
  height=100
) }}



{{ figure_markup(
  image="top-layout-methods.png",
  caption="The most commonly-declared layout types.",
  description="TODO",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRXMwdR5iy0KEMBzUWuZqDfWsj8HDDJcd5lFfjJpBmJr8gI1TE3xz2BzbNB9SEzSrxDtxfqvDvnvbQ3/pubchart?oid=1090750625&format=interactive",
  height=756,
  sheets_gid="1349743417",
  sql_file="layout_properties.sql"
) }}



{{ figure_markup(
  image="flexbox-grid-adoption.png",
  caption="Adoption of Flexbox and Grid layout on mobile devices.",
  description="TODO",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRXMwdR5iy0KEMBzUWuZqDfWsj8HDDJcd5lFfjJpBmJr8gI1TE3xz2BzbNB9SEzSrxDtxfqvDvnvbQ3/pubchart?oid=1784148592&format=interactive",
  sheets_gid="928762069",
  sql_file="flexbox_grid.sql"
) }}



{{ figure_markup(
  image="border-box-declarations-per-page.png",
  caption="Distribution of the median number of `border-box` declarations per page.",
  description="TODO",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRXMwdR5iy0KEMBzUWuZqDfWsj8HDDJcd5lFfjJpBmJr8gI1TE3xz2BzbNB9SEzSrxDtxfqvDvnvbQ3/pubchart?oid=1213231382&format=interactive",
  sheets_gid="477060329",
  sql_file="box_sizing.sql"
) }}



{{ figure_markup(
  image="most-popular-transition-properties.png",
  caption="The most popular properties given transition effects.",
  description="TODO",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRXMwdR5iy0KEMBzUWuZqDfWsj8HDDJcd5lFfjJpBmJr8gI1TE3xz2BzbNB9SEzSrxDtxfqvDvnvbQ3/pubchart?oid=1505834154&format=interactive",
  sheets_gid="1623088261",
  sql_file="transition_properties.sql"
) }}



{{ figure_markup(
  image="distribution-of-transition-durations.png",
  caption="Distribution of transition durations.",
  description="TODO",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRXMwdR5iy0KEMBzUWuZqDfWsj8HDDJcd5lFfjJpBmJr8gI1TE3xz2BzbNB9SEzSrxDtxfqvDvnvbQ3/pubchart?oid=894159072&format=interactive",
  sheets_gid="432079881",
  sql_file="transition_durations.sql"
) }}



{{ figure_markup(
  image="distribution-of-transition-delays.png",
  caption="Distribution of transition delays.",
  description="TODO",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRXMwdR5iy0KEMBzUWuZqDfWsj8HDDJcd5lFfjJpBmJr8gI1TE3xz2BzbNB9SEzSrxDtxfqvDvnvbQ3/pubchart?oid=501863648&format=interactive",
  sheets_gid="909003541",
  sql_file="transition_delays.sql"
) }}



{{ figure_markup(
  image="timing-functions.png",
  caption="Adoption of transition timing functions.",
  description="TODO",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRXMwdR5iy0KEMBzUWuZqDfWsj8HDDJcd5lFfjJpBmJr8gI1TE3xz2BzbNB9SEzSrxDtxfqvDvnvbQ3/pubchart?oid=1700244926&format=interactive",
  sheets_gid="1217291895",
  sql_file="transition_timing_functions.sql"
) }}



{{ figure_markup(
  image="animation-name-categories.png",
  caption="The most popular types of animation.",
  description="TODO",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRXMwdR5iy0KEMBzUWuZqDfWsj8HDDJcd5lFfjJpBmJr8gI1TE3xz2BzbNB9SEzSrxDtxfqvDvnvbQ3/pubchart?oid=676429696&format=interactive",
  sheets_gid="721830186",
  sql_file="transition_animation_names.sql"
) }}



{{ figure_markup(
  image="media-query-features.png",
  caption="The most popular features used as media queries.",
  description="TODO",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRXMwdR5iy0KEMBzUWuZqDfWsj8HDDJcd5lFfjJpBmJr8gI1TE3xz2BzbNB9SEzSrxDtxfqvDvnvbQ3/pubchart?oid=1275783028&format=interactive",
  height=671,
  sheets_gid="1192142763",
  sql_file="media_query_features.sql"
) }}



{{ figure_markup(
  image="most-popular-breakpoints.png",
  caption="The most popular media query breakpoints.",
  description="TODO",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRXMwdR5iy0KEMBzUWuZqDfWsj8HDDJcd5lFfjJpBmJr8gI1TE3xz2BzbNB9SEzSrxDtxfqvDvnvbQ3/pubchart?oid=990843085&format=interactive",
  sheets_gid="1275086846",
  sql_file="media_query_values.sql"
) }}



{{ figure_markup(
  image="most-popular-properties-used-in-media-queries.png",
  caption="The most popular properties to be changed via media queries.",
  description="TODO",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRXMwdR5iy0KEMBzUWuZqDfWsj8HDDJcd5lFfjJpBmJr8gI1TE3xz2BzbNB9SEzSrxDtxfqvDvnvbQ3/pubchart?oid=285981171&format=interactive",
  sheets_gid="1782726219",
  sql_file="media_query_properties.sql"
) }}



{{ figure_markup(
  image="most-popular-features-queried.png",
  caption="The most popular CSS features to be queried with `@supports`.",
  description="TODO",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRXMwdR5iy0KEMBzUWuZqDfWsj8HDDJcd5lFfjJpBmJr8gI1TE3xz2BzbNB9SEzSrxDtxfqvDvnvbQ3/pubchart?oid=1806919245&format=interactive",
  sheets_gid="349568482",
  sql_file="supports_criteria.sql"
) }}



{{ figure_markup(
  image="custom-property-usage.png",
  caption="Change in custom property usage, 2019-2021.",
  description="TODO",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRXMwdR5iy0KEMBzUWuZqDfWsj8HDDJcd5lFfjJpBmJr8gI1TE3xz2BzbNB9SEzSrxDtxfqvDvnvbQ3/pubchart?oid=752724350&format=interactive",
  sheets_gid="1813615348",
  sql_file="custom_property_adoption.sql"
) }}



{{ figure_markup(
  image="custom-property-names.png",
  caption="The most popular custom property names.",
  description="TODO",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRXMwdR5iy0KEMBzUWuZqDfWsj8HDDJcd5lFfjJpBmJr8gI1TE3xz2BzbNB9SEzSrxDtxfqvDvnvbQ3/pubchart?oid=205956063&format=interactive",
  sheets_gid="725813203",
  sql_file="custom_property_names.sql"
) }}



{{ figure_markup(
  image="custom-property-properties.png",
  caption="The most popular properties to be given a custom-property value.",
  description="TODO",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRXMwdR5iy0KEMBzUWuZqDfWsj8HDDJcd5lFfjJpBmJr8gI1TE3xz2BzbNB9SEzSrxDtxfqvDvnvbQ3/pubchart?oid=951347176&format=interactive",
  sheets_gid="1369726995",
  sql_file="custom_property_properties.sql"
) }}



{{ figure_markup(
  image="custom-property-value-types.png",
  caption="Distribution of types of custom property values.",
  description="TODO",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRXMwdR5iy0KEMBzUWuZqDfWsj8HDDJcd5lFfjJpBmJr8gI1TE3xz2BzbNB9SEzSrxDtxfqvDvnvbQ3/pubchart?oid=1962152689&format=interactive",
  sheets_gid="2132273363",
  sql_file="custom_property_value_types.sql"
) }}



{{ figure_markup(
  image="custom-property-depth.png",
  caption="Distribution of median custom property depth.",
  description="TODO",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRXMwdR5iy0KEMBzUWuZqDfWsj8HDDJcd5lFfjJpBmJr8gI1TE3xz2BzbNB9SEzSrxDtxfqvDvnvbQ3/pubchart?oid=1735836564&format=interactive",
  sheets_gid="1066390528",
  sql_file="custom_property_depth.sql"
) }}



{{ figure_markup(
  image="logical-property-and-value-usage.png",
  caption="Distribution of property types of logical properties.",
  description="TODO",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRXMwdR5iy0KEMBzUWuZqDfWsj8HDDJcd5lFfjJpBmJr8gI1TE3xz2BzbNB9SEzSrxDtxfqvDvnvbQ3/pubchart?oid=190768531&format=interactive",
  sheets_gid="1595217858",
  sql_file="i18n_logical_properties.sql"
) }}



{{ figure_markup(
  image="css-in-js-libraries.png",
  caption="Distribution of CSS-in-JS libraries.",
  description="TODO",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRXMwdR5iy0KEMBzUWuZqDfWsj8HDDJcd5lFfjJpBmJr8gI1TE3xz2BzbNB9SEzSrxDtxfqvDvnvbQ3/pubchart?oid=1003466201&format=interactive",
  sheets_gid="1851845193",
  sql_file="css_in_js.sql"
) }}



{{ figure_markup(
  image="declaration-repetition.png",
  caption="Distribution of repetition of declarations per page.",
  description="TODO",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRXMwdR5iy0KEMBzUWuZqDfWsj8HDDJcd5lFfjJpBmJr8gI1TE3xz2BzbNB9SEzSrxDtxfqvDvnvbQ3/pubchart?oid=1849063734&format=interactive",
  sheets_gid="560362648",
  sql_file="repetition.sql"
) }}



{{ figure_markup(
  image="most-popular-longhand-properties-after-shorthands.png",
  caption="The most common longhand properties to appear after their corresponding shorthand properties.",
  description="TODO",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRXMwdR5iy0KEMBzUWuZqDfWsj8HDDJcd5lFfjJpBmJr8gI1TE3xz2BzbNB9SEzSrxDtxfqvDvnvbQ3/pubchart?oid=1051485878&format=interactive",
  sheets_gid="1761101514",
  sql_file="meta_shorthand_first_properties.sql"
) }}



{{ figure_markup(
  image="usage-of-background-shorthand-vs-longhands.png",
  caption="The most commonly used background properties.",
  description="TODO",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRXMwdR5iy0KEMBzUWuZqDfWsj8HDDJcd5lFfjJpBmJr8gI1TE3xz2BzbNB9SEzSrxDtxfqvDvnvbQ3/pubchart?oid=668445598&format=interactive",
  height=429,
  sheets_gid="886194727",
  sql_file="all_properties.sql"
) }}



{{ figure_markup(
  image="usage-of-margin-padding-shorthands-vs-longhands.png",
  caption="The most commonly used margin and padding properties.",
  description="TODO",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRXMwdR5iy0KEMBzUWuZqDfWsj8HDDJcd5lFfjJpBmJr8gI1TE3xz2BzbNB9SEzSrxDtxfqvDvnvbQ3/pubchart?oid=918848418&format=interactive",
  sheets_gid="886194727",
  sql_file="all_properties.sql"
) }}



{{ figure_markup(
  image="usage-of-font-shorthand-vs-longhands.png",
  caption="The most commonly used font properties",
  description="TODO",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRXMwdR5iy0KEMBzUWuZqDfWsj8HDDJcd5lFfjJpBmJr8gI1TE3xz2BzbNB9SEzSrxDtxfqvDvnvbQ3/pubchart?oid=1034544520&format=interactive",
  sheets_gid="886194727",
  sql_file="all_properties.sql"
) }}



{{ figure_markup(
  image="usage-of-flex-shorthands-vs-longhands.png",
  caption="The most commonly used Flexbox-related properties.",
  description="TODO",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRXMwdR5iy0KEMBzUWuZqDfWsj8HDDJcd5lFfjJpBmJr8gI1TE3xz2BzbNB9SEzSrxDtxfqvDvnvbQ3/pubchart?oid=772069330&format=interactive",
  sheets_gid="886194727",
  sql_file="all_properties.sql"
) }}



{{ figure_markup(
  image="usage-of-grid-properties.png",
  caption="The most commonly used Grid-related properties.",
  description="TODO",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRXMwdR5iy0KEMBzUWuZqDfWsj8HDDJcd5lFfjJpBmJr8gI1TE3xz2BzbNB9SEzSrxDtxfqvDvnvbQ3/pubchart?oid=2100289470&format=interactive",
  height=575,
  sheets_gid="886194727",
  sql_file="all_properties.sql"
) }}



{{ figure_markup(
  image="most-popular-unknown-properties.png",
  caption="The most common unknown properties.",
  description="TODO",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRXMwdR5iy0KEMBzUWuZqDfWsj8HDDJcd5lFfjJpBmJr8gI1TE3xz2BzbNB9SEzSrxDtxfqvDvnvbQ3/pubchart?oid=946019101&format=interactive",
  height=401,
  sheets_gid="1993096589",
  sql_file="meta_unknown_properties.sql"
) }}



{{ figure_markup(
  image="most-common-shorthands-after-longhands.png",
  caption="The most common shorthand properties to (improperly) appear after any of their corresponding longhand properties.",
  description="TODO",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRXMwdR5iy0KEMBzUWuZqDfWsj8HDDJcd5lFfjJpBmJr8gI1TE3xz2BzbNB9SEzSrxDtxfqvDvnvbQ3/pubchart?oid=288419798&format=interactive",
  height=388,
  sheets_gid="1352208996",
  sql_file="meta_longhand_first_properties.sql"
) }}



{{ figure_markup(
  image="most-popular-sass-function-calls.png",
  caption="The most commonly used Sass function calls.",
  description="TODO",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRXMwdR5iy0KEMBzUWuZqDfWsj8HDDJcd5lFfjJpBmJr8gI1TE3xz2BzbNB9SEzSrxDtxfqvDvnvbQ3/pubchart?oid=714529985&format=interactive",
  height=552,
  sheets_gid="400373190",
  sql_file="sass_function_calls.sql"
) }}



{{ figure_markup(
  image="usage-of-control-flow-statements-in-scss.png",
  caption="The most commonly used Sass flow control structures.",
  description="TODO",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRXMwdR5iy0KEMBzUWuZqDfWsj8HDDJcd5lFfjJpBmJr8gI1TE3xz2BzbNB9SEzSrxDtxfqvDvnvbQ3/pubchart?oid=438915471&format=interactive",
  sheets_gid="920758691",
  sql_file="sass_control_flow_statements.sql"
) }}



{{ figure_markup(
  image="usage-of-explicit-nesting-in-scss.png",
  caption="The prevalence of rule-nesting in Sass.",
  description="TODO",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRXMwdR5iy0KEMBzUWuZqDfWsj8HDDJcd5lFfjJpBmJr8gI1TE3xz2BzbNB9SEzSrxDtxfqvDvnvbQ3/pubchart?oid=61926709&format=interactive",
  height=455,
  sheets_gid="1859409315",
  sql_file="sass_nesting.sql"
) }}
