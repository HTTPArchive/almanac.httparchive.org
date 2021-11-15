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
  description="A paired-column chart showing the 10th, 25th, 50th, 75th, and 90th percentile median values for the total weight of the stylesheets for a page.  The numbers are as follows.  10th percentile, 9 kilobytes on desktop and 6 kilobytes on mobile.  25th percentile, 31 KB desktop and 27 KB mobile.  50th percentile, 71 KB desktop and 66 KB mobile.  75th percentile, 142 KB desktop and 135KB mobile.  90th percentile, 257 KB desktop and 250 KB mobile.",
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
  description="A paired-column chart showing the 10th, 25th, 50th, 75th, and 90th percentile median values for the total number of stylesheets loaded per page.  The results are as follows.  10th percentile, 1 stylesheet for desktop and 1 stylesheet for mobile.  25th percentile, 3 for both desktop and mobile.  50th percentile, 7 for desktop and 6 for mobile.  75th percentile, 13 for both desktop and mobile.  90th percentile, 22 for both desktop and mobile.",
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
  description="A paired-column chart showing the 10th, 25th, 50th, 75th, and 90th percentile median values for the total number of CSS rules.  The results are as follows.  10th percentile, 17 rules for desktop and 15 rules for mobile.  25th percentile, 145 rules for desktop and 152 for mobile.  50th percentile, 512 for desktop and 483 for mobile.  75th percentile, 1,078 for desktop and 1,063 for mobile.  90th percentile, 1,841 for  desktop and 1,821 for mobile.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRXMwdR5iy0KEMBzUWuZqDfWsj8HDDJcd5lFfjJpBmJr8gI1TE3xz2BzbNB9SEzSrxDtxfqvDvnvbQ3/pubchart?oid=472863207&format=interactive",
  sheets_gid="697775839",
  sql_file="selectors.sql"
) }}



{{ figure_markup(
  image="most-popular-class-names.png",
  caption="The most popular class names.",
  description="A chart showing the most popular class names, with percentage share given for mobile.  The desktop bars are all within a percent or two of their mobile cousins.  The list is as follows, with the values indicating the percent of all pages containing the given class name: active 42%; fa 32%; fa-* 32%, pull-right 29%, pull-left 28%, disabled 24%, selected 22%, button 22%, container 20%, wp-* 20%, sr-only 20%, title 20%, btn 19%, sr-only-focusable 19%, clearfix 17%, current 16%, right 16%, rtl 15%, widget 15%, row 15%.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRXMwdR5iy0KEMBzUWuZqDfWsj8HDDJcd5lFfjJpBmJr8gI1TE3xz2BzbNB9SEzSrxDtxfqvDvnvbQ3/pubchart?oid=1533988979&format=interactive",
  width=600,
  height=691,
  sheets_gid="982850647",
  sql_file="top_selector_classes_wp_fa_prefixes.sql"
) }}



{{ figure_markup(
  image="most-popular-id-names.png",
  caption="The most popular ID names.",
  description="A chart showing the most popular ID names, with percentage share given for mobile.  The desktop bars are all within a percent or two of their mobile cousins.  The list is as follows, with the values indicating the percent of all pages containing the given ID name: content 14%, footer 11%, header 10%, logo 7%, rc-imageselect 7%, comments 7%, main 7%, rc-anchor-alert 7%, rc-anchor-over-quota 7%, rc-anchor-invisible-over 7%",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRXMwdR5iy0KEMBzUWuZqDfWsj8HDDJcd5lFfjJpBmJr8gI1TE3xz2BzbNB9SEzSrxDtxfqvDvnvbQ3/pubchart?oid=609865919&format=interactive",
  width=600,
  height=497,
  sheets_gid="289906540",
  sql_file="top_selector_ids.sql"
) }}



{{ figure_markup(
  image="most-popular-attribute-selectors.png",
  caption="The most popular attribute selectors.",
  description="A chart listing the most popular attributes selected via attribute selectors.  The list is as follows: type, class, disabled, dir, title, hidden, aria-disabled, role, href, controls, src, style, data-type, lang, xmlns, id, data-align, poster, name, readonly.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRXMwdR5iy0KEMBzUWuZqDfWsj8HDDJcd5lFfjJpBmJr8gI1TE3xz2BzbNB9SEzSrxDtxfqvDvnvbQ3/pubchart?oid=1836678858&format=interactive",
  sheets_gid="942534767",
  sql_file="top_selector_attributes.sql"
) }}



{{ figure_markup(
  image="most-popular-pseudo-classes.png",
  caption="The most popular pseudo-classes.",
  description="A chart listing the most popular pseudo-classes.  The list is as follows: hover, focus, active, first-child, last-child, not, visited, root, nth-child, link, disabled, empty, checked, -ms-input, last-of-type.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRXMwdR5iy0KEMBzUWuZqDfWsj8HDDJcd5lFfjJpBmJr8gI1TE3xz2BzbNB9SEzSrxDtxfqvDvnvbQ3/pubchart?oid=1619223389&format=interactive",
  sheets_gid="843054585",
  sql_file="top_selector_pseudo_classes.sql"
) }}



{{ figure_markup(
  image="most-popular-unprefixed-pseudo-elements.png",
  caption="The most popular unprefixed pseudo-elements.",
  description="A chart listing the most popular pseudo-elements that are not vendor prefixed.  The list is as follows: before, after, selection, placeholder, first-letter, marker.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRXMwdR5iy0KEMBzUWuZqDfWsj8HDDJcd5lFfjJpBmJr8gI1TE3xz2BzbNB9SEzSrxDtxfqvDvnvbQ3/pubchart?oid=1825062416&format=interactive",
  height=500,
  sheets_gid="1863963291",
  sql_file="top_selector_pseudo_elements.sql"
) }}



{{ figure_markup(
  image="important-properties-per-page.png",
  caption="Distribution of the percentage of page rules using `!important`.",
  description="A paired-column chart showing the 10th, 25th, 50th, 75th, and 90th percentile median values for the percentage of properties marked important with the '!important' keyword.  The results are as follows.  10th percentile, 0% for both desktop and mobile.  25th percentile, 1% for both desktop and mobile.  50th percentile, 2% for both desktop and mobile.  75th percentile, 4% for both desktop and mobile.  90th percentile, 8% for both desktop and mobile.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRXMwdR5iy0KEMBzUWuZqDfWsj8HDDJcd5lFfjJpBmJr8gI1TE3xz2BzbNB9SEzSrxDtxfqvDvnvbQ3/pubchart?oid=1184051032&format=interactive",
  sheets_gid="1176732383",
  sql_file="meta_important_adoption.sql"
) }}



{{ figure_markup(
  image="top-important-properties.png",
  caption="The most popular properties targeted by `!important`.",
  description="A chart showing the properties most likely to be marked important using the '!important' keyword, as a percentage of all pages containing a property so marked.  Values are only given for mobile, but the desktop bars are all within a percent or two of their mobile counterparts.  The list is as follows: display 81% of pages, color 74% of pages, width 72%, height 70%, background 69%, padding 69%, margin 67%, border 66%, background-color 65%, position 61%.",
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
  description="A paired-column chart showing the most popular units used in length values.  The results are as follows.  px (pixel) 71% for both desktop and mobile.  % (percentage) 17% for desktop, 18% for mobile.  em (the m unit) 9% for both desktop and mobile.  rem (root-relative em) 2% for both desktop and mobile.",
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
  description="A pie chart with the following results.  em (the m unit) 81.7%, rem (root-relative em) 17.8%, ch (zero-width advance) 0.5%.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRXMwdR5iy0KEMBzUWuZqDfWsj8HDDJcd5lFfjJpBmJr8gI1TE3xz2BzbNB9SEzSrxDtxfqvDvnvbQ3/pubchart?oid=658259611&format=interactive",
  sheets_gid="529909801",
  sql_file="units_properties.sql"
) }}



{{ figure_markup(
  image="zero-lengths-by-unit.png",
  caption="The units (or lack thereof) used on zero-length values.",
  description="A pie chart with the following results.  Unitless zero values 87.8%, 0px (pixels) 11.6%, all others 0.6%.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRXMwdR5iy0KEMBzUWuZqDfWsj8HDDJcd5lFfjJpBmJr8gI1TE3xz2BzbNB9SEzSrxDtxfqvDvnvbQ3/pubchart?oid=758334535&format=interactive",
  sheets_gid="2139699206",
  sql_file="units_zero.sql"
) }}



{{ figure_markup(
  image="most-popular-properties-using-calc.png",
  caption="The most popular properties using `calc()` functions.",
  description="A paired-column chart where values are only given for mobile, but the desktop bars are all within a percent or two of their mobile counterparts.  The list is as follows: width 39%, left 18%, top 7%, height 5%, max-width 5%, min-height 3%, margin-left 3%, margin-right 3%, max-height 2%, right 2%, padding-bottom 1%, flex-basis 1%, padding-left 1%, font-size 1%, margin-top 1%.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRXMwdR5iy0KEMBzUWuZqDfWsj8HDDJcd5lFfjJpBmJr8gI1TE3xz2BzbNB9SEzSrxDtxfqvDvnvbQ3/pubchart?oid=907378413&format=interactive",
  sheets_gid="212269204",
  sql_file="calc_properties.sql"
) }}



{{ figure_markup(
  image="most-popular-units-using-calc.png",
  caption="The most popular length units used in `calc()` functions.",
  description="A paired-column chart showing the value units most likely to be used in calculation values.  Values are only given for mobile, but the desktop bars are all within a percent or two of their mobile counterparts.  The list is as follows: px (pixels) 51%, percentage 38%, rem (root-relative em) 3%, vw (viewport width) 2%, em (the m unit) 2%, vh (viewport height) 2%.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRXMwdR5iy0KEMBzUWuZqDfWsj8HDDJcd5lFfjJpBmJr8gI1TE3xz2BzbNB9SEzSrxDtxfqvDvnvbQ3/pubchart?oid=833777702&format=interactive",
  sheets_gid="605954740",
  sql_file="calc_units.sql"
) }}



{{ figure_markup(
  image="most-popular-operators-using-calc.png",
  caption="The most popular operators used in `calc()` functions.",
  description="A paired-column chart where values are only given for mobile, but the desktop bars are all within a percent or two of their mobile counterparts.  The list is as follows: - 61%. + 18%, / (division) 14%, * (multiplication) 7%.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRXMwdR5iy0KEMBzUWuZqDfWsj8HDDJcd5lFfjJpBmJr8gI1TE3xz2BzbNB9SEzSrxDtxfqvDvnvbQ3/pubchart?oid=1708226150&format=interactive",
  sheets_gid="464539022",
  sql_file="calc_operators.sql"
) }}



{{ figure_markup(
  image="units-per-calc-occurence.png",
  caption="The number of unique units used in `calc()` functions.",
  description="A paired-column chart where values are only given for mobile, but the desktop bars are all within a percent or two of their mobile counterparts.  The list is as follows.  One unit type, 16%.  Two unit types, 82%.  Three or mroe unit types, 1%.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRXMwdR5iy0KEMBzUWuZqDfWsj8HDDJcd5lFfjJpBmJr8gI1TE3xz2BzbNB9SEzSrxDtxfqvDvnvbQ3/pubchart?oid=276182784&format=interactive",
  sheets_gid="856430777",
  sql_file="calc_complexity_units.sql"
) }}



{{ figure_markup(
  image="global-keyword-adoption.png",
  caption="Usage of global keyword values.",
  description="A paired-column chart showing the usage of global keywords as a percentage of all pages using any global keyword.  Values are only given for mobile, but the desktop bars are all within a percent or two of their mobile counterparts.  The list is as follows: inherit 87%, initial 57%, unset 48%, revert 1%.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRXMwdR5iy0KEMBzUWuZqDfWsj8HDDJcd5lFfjJpBmJr8gI1TE3xz2BzbNB9SEzSrxDtxfqvDvnvbQ3/pubchart?oid=884074059&format=interactive",
  sheets_gid="731307554",
  sql_file="keyword_totals.sql"
) }}



{{ figure_markup(
  image="most-popular-color-formats.png",
  caption="The most popular color value formats.",
  description="A paired-column chart showing the color syntax formats used, as a percentage of all occurrences of color values.  Values are only given for mobile, but the desktop bars are all within a percent or two of their mobile counterparts.  The list is as follows: #rrggbb 50%, #rgb 25%, rgba() 14%, transparent 8%, namedColor 1%.  Beyond that, the rest of the values are shown at 0%, in this order: rgb(), hsla(), #rrggbbaa, currentColor, system, hsl(), #rgba, color().",
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
  description="A pie chart with the following results: PNG 44.1%, GIF 18.3%, SVG 17.2%, JPG 16.4%, WEBP 3.7%.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRXMwdR5iy0KEMBzUWuZqDfWsj8HDDJcd5lFfjJpBmJr8gI1TE3xz2BzbNB9SEzSrxDtxfqvDvnvbQ3/pubchart?oid=868556131&format=interactive",
  sheets_gid="1133067574",
  sql_file="image_formats.sql"
) }}



{{ figure_markup(
  image="number-of-images-loaded.png",
  caption="Distribution of the number of external images loaded via CSS.",
  description="A paired-column chart showing the 10th, 25th, 50th, 75th, and 90th percentile median values for the number of images loaded via CSS.  The results are as follows.  10th and 25th percentiles, 1 on both desktop and mobile.  50th percentile, 3 on both dekstop and mobile.  75th percentile, 6 on desktop and 5 on mobile.  90th percentile, 11 on desktop and 10 on mobile.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRXMwdR5iy0KEMBzUWuZqDfWsj8HDDJcd5lFfjJpBmJr8gI1TE3xz2BzbNB9SEzSrxDtxfqvDvnvbQ3/pubchart?oid=1206209320&format=interactive",
  sheets_gid="361647805",
  sql_file="image_weights.sql"
) }}



{{ figure_markup(
  caption="The heaviest total weight of images loaded via CSS, in KB.",
  content="314,386",
  classes="big-number",
  sheets_gid="361647805",
  sql_file="image_weights.sql"
) }}



{{ figure_markup(
  image="total-image-weight.png",
  caption="Distribution of the total weight in KB of external images loaded via CSS.",
  description="A paired-column chart showing the 10th, 25th, 50th, 75th, and 90th percentile median values for the total weight of images loaded via CSS on mobile.  The results are as follows.  10th percentile, 1.0 KB.  25th percentile, 3.0 KB.  50th percentile, 16.3 KB.  75th percentile, 119.3 KB.  90th percentile, 479.7 KB.",
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
  description="A paired-column chart where values are only given for mobile, but the desktop bars are all within a percent or two of their mobile counterparts.  The list is as follows: linear-gradient 74.3%, radial-gradient 14.5%, repeating-linear-gradient 3.7%, repeating-radial-gradient 0.1%, conic-gradient 0%, repeating-conic-gradient 0%.",
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
  description="A paired-column chart where values are only given for mobile, but the desktop bars are all within a percent or two of their mobile counterparts.  The list is as follows: absolute 93%, block 93%, inline-block 91%, floats 91%, inline 82%, fixed 82%, css-tables 81%, flex 74%, box 50%, inline-flex 39%, grid 36%, list-item 29%, inline-table 23%, inline-box 22%, stick 17%, inline-grid 12%, none 8%, flexbox 8%, inline-stack 5%, contents 5%, auto 2%.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRXMwdR5iy0KEMBzUWuZqDfWsj8HDDJcd5lFfjJpBmJr8gI1TE3xz2BzbNB9SEzSrxDtxfqvDvnvbQ3/pubchart?oid=1090750625&format=interactive",
  height=756,
  sheets_gid="1349743417",
  sql_file="layout_properties.sql"
) }}



{{ figure_markup(
  image="flexbox-grid-adoption.png",
  caption="Adoption of Flexbox and Grid layout on mobile devices.",
  description="A chart showing the increase in Flexbox and Grid adoption by year, from 2019 through 2021, on mobile.  For Flexbox, adoption was a bit below 50% in 2019, about 65% in 2020, and 71% in 2021 (only 2021 is labeled).  For Grid, adoption was 2% in 2019, 4% in 2020, and 8% in 2021.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRXMwdR5iy0KEMBzUWuZqDfWsj8HDDJcd5lFfjJpBmJr8gI1TE3xz2BzbNB9SEzSrxDtxfqvDvnvbQ3/pubchart?oid=1784148592&format=interactive",
  sheets_gid="928762069",
  sql_file="flexbox_grid.sql"
) }}



{{ figure_markup(
  image="border-box-declarations-per-page.png",
  caption="Distribution of the median number of `border-box` declarations per page.",
  description="A paired-column chart showing the 10th, 25th, 50th, 75th, and 90th percentile median values for the number of border-box declarations on a page.  The results are as follows.  For the 10th, 25th, and 50th percentiles, 0 for both desktop and mobile.  75th percentile, 2 for both desktop and mobile.  90th percentile, 9 for both desktop and mobile.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRXMwdR5iy0KEMBzUWuZqDfWsj8HDDJcd5lFfjJpBmJr8gI1TE3xz2BzbNB9SEzSrxDtxfqvDvnvbQ3/pubchart?oid=1213231382&format=interactive",
  sheets_gid="477060329",
  sql_file="box_sizing.sql"
) }}



{{ figure_markup(
  image="most-popular-transition-properties.png",
  caption="The most popular properties given transition effects.",
  description="A chart listing the most commonly animated properties for both desktop and mobile, with the values given for mobile (desktop is always within a percent or two of mobile).  The results are as follows.  all 46%, opacity 42%, transform 30%, none 20%, height 18%, color 18%, background-color 13%, background 12%, left 8%, width 8%, box-shadow 8%, -webkit-transform 7%, top 7%, border-color 6%, visibility 6%.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRXMwdR5iy0KEMBzUWuZqDfWsj8HDDJcd5lFfjJpBmJr8gI1TE3xz2BzbNB9SEzSrxDtxfqvDvnvbQ3/pubchart?oid=1505834154&format=interactive",
  sheets_gid="1623088261",
  sql_file="transition_properties.sql"
) }}



{{ figure_markup(
  image="distribution-of-transition-durations.png",
  caption="Distribution of transition durations.",
  description="A paired-column chart showing the 10th, 25th, 50th, 75th, and 90th percentile median values for transition durations.  In all percentiles save one, the values are exactly the same for desktop and mobile.  The results are as follows.  For the 10th percentile, 100 milliseconds.  For the 25th percentile, 150 milliseconds.  50th percentile, 250ms.  75th percentile, 330ms on desktop and 333ms on mobile.  90th percentile, 500ms.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRXMwdR5iy0KEMBzUWuZqDfWsj8HDDJcd5lFfjJpBmJr8gI1TE3xz2BzbNB9SEzSrxDtxfqvDvnvbQ3/pubchart?oid=894159072&format=interactive",
  sheets_gid="432079881",
  sql_file="transition_durations.sql"
) }}



{{ figure_markup(
  image="distribution-of-transition-delays.png",
  caption="Distribution of transition delays.",
  description="A paired-column chart showing the 10th, 25th, 50th, 75th, and 90th percentile median values for transition durations.  In all percentiles, the values are exactly the same for desktop and mobile.  The results are as follows.  For the 10th percentile, -320 milliseconds.  For the 25th percentile, 0 milliseconds.  50th percentile, 200ms.  75th percentile, 600ms.  90th percentile, 1,700ms.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRXMwdR5iy0KEMBzUWuZqDfWsj8HDDJcd5lFfjJpBmJr8gI1TE3xz2BzbNB9SEzSrxDtxfqvDvnvbQ3/pubchart?oid=501863648&format=interactive",
  sheets_gid="909003541",
  sql_file="transition_delays.sql"
) }}



{{ figure_markup(
  image="timing-functions.png",
  caption="Adoption of transition timing functions.",
  description="A pie chart showing the distribution of timing functions in all transitions.  The figures are as follows: ease 31.7%, linear 18.8%, ease-in-out 18.2%, cubic-bezier 14.4%, ease-out 8.3%, ease-in 4.8%, steps 3.8%.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRXMwdR5iy0KEMBzUWuZqDfWsj8HDDJcd5lFfjJpBmJr8gI1TE3xz2BzbNB9SEzSrxDtxfqvDvnvbQ3/pubchart?oid=1700244926&format=interactive",
  sheets_gid="1217291895",
  sql_file="transition_timing_functions.sql"
) }}



{{ figure_markup(
  image="animation-name-categories.png",
  caption="The most popular types of animation.",
  description="A chart listing the most popular types of animations, with the values given for mobile (desktop is always within a percent or two of mobile).  The results are as follows.  rotate 18%, unknown or other 14%, fade 9%, wobble 7%, bounce 7%, scale 6%, slide 5%, pulse 2%, visibility 2%, flip 1%, move 0%.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRXMwdR5iy0KEMBzUWuZqDfWsj8HDDJcd5lFfjJpBmJr8gI1TE3xz2BzbNB9SEzSrxDtxfqvDvnvbQ3/pubchart?oid=676429696&format=interactive",
  sheets_gid="721830186",
  sql_file="transition_animation_names.sql"
) }}



{{ figure_markup(
  image="media-query-features.png",
  caption="The most popular features used as media queries.",
  description="A chart listing the most commonly used media queries, with the values given for mobile (desktop is always within a percent or two of mobile).  The results are as follows.  max-width 81%, min-width 78%, -webkit-min-device-pixel-ratio 42%, orientation 34%, prefers-reduced-motion 32%, max-device-width 28%, min-resolution 23%, -ms-high-contrast 23%, max-height 22%, -webkit-transform-3d 14%, transform-3d 14%, min-device-pixel-ratio 14%, min--moz-device-pixel-ratio 12%, min-height 11%, -o-min-device-pixel-ratio 9%, min-device-width 8%, prefers-color-scheme 7%, forced-colors 7%, hover 4%.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRXMwdR5iy0KEMBzUWuZqDfWsj8HDDJcd5lFfjJpBmJr8gI1TE3xz2BzbNB9SEzSrxDtxfqvDvnvbQ3/pubchart?oid=1275783028&format=interactive",
  height=671,
  sheets_gid="1192142763",
  sql_file="media_query_features.sql"
) }}



{{ figure_markup(
  image="most-popular-breakpoints.png",
  caption="The most popular media query breakpoints.",
  description="A stacked-column chart listing the most popular media query breakpoints.  The results are as follows.  480 pixels, 24% min-width and 36% max-width.  600 pixels, 31% min-width and 38% max-width.  767px, 9% min-width and 52% max-width.  768px, 57% min-width and 38% max-width.  782px, 25% min-width and 10% max-width.  800px, 8% min-width and 26% max-width.  991px, 3% min-width and 30% max-width.  992px, 40% min-width and 13% max-width.  1024px, 16% min-width and 27% max-width.  1200px, 44% min-width and 18% max-width.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRXMwdR5iy0KEMBzUWuZqDfWsj8HDDJcd5lFfjJpBmJr8gI1TE3xz2BzbNB9SEzSrxDtxfqvDvnvbQ3/pubchart?oid=990843085&format=interactive",
  sheets_gid="1275086846",
  sql_file="media_query_values.sql"
) }}



{{ figure_markup(
  image="most-popular-properties-used-in-media-queries.png",
  caption="The most popular properties to be changed via media queries.",
  description="A chart with the values given for mobile (desktop is always within a percent or two of mobile).  The results are as follows.  display 81%, color 74%, width 72%, height 70%, background 69%, padding 69%, margin 67%, border 66%, background-color 65%, position 61%.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRXMwdR5iy0KEMBzUWuZqDfWsj8HDDJcd5lFfjJpBmJr8gI1TE3xz2BzbNB9SEzSrxDtxfqvDvnvbQ3/pubchart?oid=285981171&format=interactive",
  sheets_gid="1782726219",
  sql_file="media_query_properties.sql"
) }}



{{ figure_markup(
  image="most-popular-features-queried.png",
  caption="The most popular CSS features to be queried with `@supports`.",
  description="A chart with the values given for mobile (desktop is always within a percent or two of mobile).  The results are as follows.  sticky 53%, mask-image 15%, ime-aligh 7%, overflow-scrolling 6%, touch-callout 5%, grid 3%, appearance 1%, custom properties 1%, max() 1%, transform-style 1%.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRXMwdR5iy0KEMBzUWuZqDfWsj8HDDJcd5lFfjJpBmJr8gI1TE3xz2BzbNB9SEzSrxDtxfqvDvnvbQ3/pubchart?oid=1806919245&format=interactive",
  sheets_gid="349568482",
  sql_file="supports_criteria.sql"
) }}



{{ figure_markup(
  image="custom-property-usage.png",
  caption="Change in custom property usage, 2019-2021.",
  description="A chart showing the evolution over time for the use of custom properties and the var() value function.  Custom properties were used in 5% of stylesheets using custom-property features in 2019, 19.3% in 2020, and 28.6% in 2021.  The var() value function was used in 27% of stylesheets using custom-property features in 2020 and 35.2% in 2021.  There is no data for 2019 for var().",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRXMwdR5iy0KEMBzUWuZqDfWsj8HDDJcd5lFfjJpBmJr8gI1TE3xz2BzbNB9SEzSrxDtxfqvDvnvbQ3/pubchart?oid=752724350&format=interactive",
  sheets_gid="1813615348",
  sql_file="custom_property_adoption.sql"
) }}



{{ figure_markup(
  image="custom-property-names.png",
  caption="The most popular custom property names.",
  description="A chart listing the most popular custom properties names.  The results are given for mobile, as desktop is always within a percent or two.  The results are: --wp-style--color--link, 18.1%.  --wp-admin-theme-color, 7.5%.  --red, --blue, and --gren are all at 7.2%.  --dark and --white are both at 7.1%.  --primary and --secondary are at 6.9%.  --gray-dark, 6.8%.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRXMwdR5iy0KEMBzUWuZqDfWsj8HDDJcd5lFfjJpBmJr8gI1TE3xz2BzbNB9SEzSrxDtxfqvDvnvbQ3/pubchart?oid=205956063&format=interactive",
  sheets_gid="725813203",
  sql_file="custom_property_names.sql"
) }}



{{ figure_markup(
  image="custom-property-properties.png",
  caption="The most popular properties to be given a custom-property value.",
  description="A chart with the values given for mobile (desktop is always within a percent or two of mobile).  The results are as follows.  color 31%, background-color 17%, background 15%, border-color 13%, height 12%, width 12%, border 11%, box-shadow 11%, margin-top 10%, font-size 9%.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRXMwdR5iy0KEMBzUWuZqDfWsj8HDDJcd5lFfjJpBmJr8gI1TE3xz2BzbNB9SEzSrxDtxfqvDvnvbQ3/pubchart?oid=951347176&format=interactive",
  sheets_gid="1369726995",
  sql_file="custom_property_properties.sql"
) }}



{{ figure_markup(
  image="custom-property-value-types.png",
  caption="Distribution of types of custom property values.",
  description="A pie chart with the values given for mobile.  The results are: color 40%, dimension (length) 27.2%, font_stack 10.9%, number 11.1%, other 10.8%.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRXMwdR5iy0KEMBzUWuZqDfWsj8HDDJcd5lFfjJpBmJr8gI1TE3xz2BzbNB9SEzSrxDtxfqvDvnvbQ3/pubchart?oid=1962152689&format=interactive",
  sheets_gid="2132273363",
  sql_file="custom_property_value_types.sql"
) }}



{{ figure_markup(
  image="custom-property-depth.png",
  caption="Distribution of median custom property depth.",
  description="A paired-column chart.  The results are as follows.  For zero custom property depth, 64% of desktop and 68% of mobile occurrences.  For one level of custom property depth, 32% on desktop and 29% on mobile.  For two levels of depth, 3% on both desktop and mobile.  For three or more levels, 0% on both desktop and mobile.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRXMwdR5iy0KEMBzUWuZqDfWsj8HDDJcd5lFfjJpBmJr8gI1TE3xz2BzbNB9SEzSrxDtxfqvDvnvbQ3/pubchart?oid=1735836564&format=interactive",
  sheets_gid="1066390528",
  sql_file="custom_property_depth.sql"
) }}



{{ figure_markup(
  image="logical-property-and-value-usage.png",
  caption="Distribution of property types of logical properties.",
  description="A pie chart showing distribution on mobile.  The results are: text-align 34%, margin 26.4%, padding 21.6%, border 11.8%, size 2.2%, min-size 2%.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRXMwdR5iy0KEMBzUWuZqDfWsj8HDDJcd5lFfjJpBmJr8gI1TE3xz2BzbNB9SEzSrxDtxfqvDvnvbQ3/pubchart?oid=190768531&format=interactive",
  sheets_gid="1595217858",
  sql_file="i18n_logical_properties.sql"
) }}



{{ figure_markup(
  image="css-in-js-libraries.png",
  caption="Distribution of CSS-in-JS libraries.",
  description="A pie chart showing distribution on mobile.  The results are: Styled Components 57.7%, Emotion 24.4%, Glamor 7.5%, Aphrodite 6.6%, Styled Jsx 2%.  There are a few tiny slices that are not labeled.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRXMwdR5iy0KEMBzUWuZqDfWsj8HDDJcd5lFfjJpBmJr8gI1TE3xz2BzbNB9SEzSrxDtxfqvDvnvbQ3/pubchart?oid=1003466201&format=interactive",
  sheets_gid="1851845193",
  sql_file="css_in_js.sql"
) }}



{{ figure_markup(
  image="declaration-repetition.png",
  caption="Distribution of repetition of declarations per page.",
  description="A paired-column chart showing the 10th, 25th, 50th, 75th, and 90th percentile median values for the percentage of properties that are repetitively declared.  Each percentile has two columns, one for desktop and one for mobile, but only mobile values are given (desktop is always within a percent or two).  The numbers are as follows.  10th percentile, 30%.  25th percentile, 36%.  50th percentile, 44%.  75th percentile, 53%.  90th percentile, 62%.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRXMwdR5iy0KEMBzUWuZqDfWsj8HDDJcd5lFfjJpBmJr8gI1TE3xz2BzbNB9SEzSrxDtxfqvDvnvbQ3/pubchart?oid=1849063734&format=interactive",
  sheets_gid="560362648",
  sql_file="repetition.sql"
) }}



{{ figure_markup(
  image="most-popular-longhand-properties-after-shorthands.png",
  caption="The most common longhand properties to appear after their corresponding shorthand properties.",
  description="A chart listing with all values given for mobile (desktop is always within a percent or two).  The results are as follows.  background-size, 15%.  background image, 7%.  margin-bottom, margin-top, border-bottom-color, and font size, 5%.  border-top-color, 4%.  margin-left, line-height, and background color, 3%. ",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRXMwdR5iy0KEMBzUWuZqDfWsj8HDDJcd5lFfjJpBmJr8gI1TE3xz2BzbNB9SEzSrxDtxfqvDvnvbQ3/pubchart?oid=1051485878&format=interactive",
  sheets_gid="1761101514",
  sql_file="meta_shorthand_first_properties.sql"
) }}



{{ figure_markup(
  image="usage-of-background-shorthand-vs-longhands.png",
  caption="The most commonly used background properties.",
  description="A chart with all values given for mobile (desktop is almost always within a percent or two).  The results are as follows.  background 96%, background-color 95%, background-position 91%, background-image 90%, background-repeat 85%, background-size 82%, background-clip 47% width desktop at 56%, background-attachment 37%, background-origin 5% with desktop nearly 0%.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRXMwdR5iy0KEMBzUWuZqDfWsj8HDDJcd5lFfjJpBmJr8gI1TE3xz2BzbNB9SEzSrxDtxfqvDvnvbQ3/pubchart?oid=668445598&format=interactive",
  height=429,
  sheets_gid="886194727",
  sql_file="all_properties.sql"
) }}



{{ figure_markup(
  image="usage-of-margin-padding-shorthands-vs-longhands.png",
  caption="The most commonly used margin and padding properties.",
  description="A chart with all values given for mobile (desktop is almost always within a percent or two).  The results are as follows.  margin-left 96%, margin 9%, margin-top and padding 93%.  padding-bottom, margin-bottom, and margin-right, 92%.  padding-left 91%, padding-right 90%.  padding-top 73%, with desktop at 90%.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRXMwdR5iy0KEMBzUWuZqDfWsj8HDDJcd5lFfjJpBmJr8gI1TE3xz2BzbNB9SEzSrxDtxfqvDvnvbQ3/pubchart?oid=918848418&format=interactive",
  sheets_gid="886194727",
  sql_file="all_properties.sql"
) }}



{{ figure_markup(
  image="usage-of-font-shorthand-vs-longhands.png",
  caption="The most commonly used font properties",
  description="A chart with all values given for mobile (desktop is almost always within a percent or two).  The results are as follows.  font-size 95%, font-familt 94%, font-weight 92%, font-style 86%, font 82% with desktop at 57%, font-variant 23% with desktop at 12%, font-stretch 5%.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRXMwdR5iy0KEMBzUWuZqDfWsj8HDDJcd5lFfjJpBmJr8gI1TE3xz2BzbNB9SEzSrxDtxfqvDvnvbQ3/pubchart?oid=1034544520&format=interactive",
  sheets_gid="886194727",
  sql_file="all_properties.sql"
) }}


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
        <td>font-variant</td>
        <td class="numeric">3,098,211</td>
        <td class="numeric">3,641,216</td>
      </tr>
      <tr>
        <td>font-variant-numeric</td>
        <td class="numeric">153,932</td>
        <td class="numeric">166,744</td>
      </tr>
      <tr>
        <td>font-variant-ligatures</td>
        <td class="numeric">107,211</td>
        <td class="numeric">112,345</td>
      </tr>
      <tr>
        <td>font-variant-caps</td>
        <td class="numeric">81,734</td>
        <td class="numeric">86,673</td>
      </tr>
      <tr>
        <td>font-variant-east-asian</td>
        <td class="numeric">20,662</td>
        <td class="numeric">20,340</td>
      </tr>
      <tr>
        <td>font-variant-position</td>
        <td class="numeric">5,198</td>
        <td class="numeric">5,842</td>
      </tr>
      <tr>
        <td>font-variant-alternates</td>
        <td class="numeric">4,876</td>
        <td class="numeric">5,511</td>
      </tr>
    </tbody>
  </table>
  <figcaption>{{ figure_link(
    caption="Number of pages using font-variant properties.",
    sheets_gid="886194727",
    sql_file="all_properties.sql"
  ) }}</figcaption>
</figure>


{{ figure_markup(
  image="usage-of-flex-shorthands-vs-longhands.png",
  caption="The most commonly used Flexbox-related properties.",
  description="A paired-column chart.  The results are as follows.  flex-basis, 35% desktop and 82% mobile.  flex-direction, 90% desktop and 75% mobile.  flex, 89% desktop and 68% mobile.  flex-grow, 43% desktop and 66% mobile.  flex-wrap, 70% desktop and 66% mobile.  flex-flow, 23% desktop and 35% mobile.  flex-shrink, 32% for both desktop and mobile.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRXMwdR5iy0KEMBzUWuZqDfWsj8HDDJcd5lFfjJpBmJr8gI1TE3xz2BzbNB9SEzSrxDtxfqvDvnvbQ3/pubchart?oid=772069330&format=interactive",
  sheets_gid="886194727",
  sql_file="all_properties.sql"
) }}



{{ figure_markup(
  image="usage-of-grid-properties.png",
  caption="The most commonly used Grid-related properties.",
  description="A chart with all values given for mobile.  The results are as follows: grid-template-columns 71%, grid-template-rows 34%, grid-row-start 33%, grid-row 32%, grid-column-start 27%, grid-column-end 26%, grid-template-areas 25%, grid-gap 24%, grid-column 23%, grid-row-end 10%, grid-area 9%, grid-column-gap 9%, grid-auto-flow 3%, grid-row-gap 2%, grid-auto-rows 1%.  The following are all at 0%: grid-auto-column, grid-template, grid, grid-column-span, grid-columns, grid-rows.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRXMwdR5iy0KEMBzUWuZqDfWsj8HDDJcd5lFfjJpBmJr8gI1TE3xz2BzbNB9SEzSrxDtxfqvDvnvbQ3/pubchart?oid=2100289470&format=interactive",
  height=575,
  sheets_gid="886194727",
  sql_file="all_properties.sql"
) }}



{{ figure_markup(
  image="most-popular-unknown-properties.png",
  caption="The most common unknown properties.",
  description="A chart listing results for mobile.  The results are: webkit-transition 14%, font-smoothing 14%, tap-highlight-color 9%, behavior 8%, box-orient 5%, -archetype 4%.  webkit-box-orient, box-flex, box-align, and box-pack are all 3%.  ms-transform and margin-center are both 2%.  Font-rendering, user-drag, and text-fill-color are all just above 0%.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRXMwdR5iy0KEMBzUWuZqDfWsj8HDDJcd5lFfjJpBmJr8gI1TE3xz2BzbNB9SEzSrxDtxfqvDvnvbQ3/pubchart?oid=946019101&format=interactive",
  height=401,
  sheets_gid="1993096589",
  sql_file="meta_unknown_properties.sql"
) }}



{{ figure_markup(
  image="most-common-shorthands-after-longhands.png",
  caption="The most common shorthand properties to (improperly) appear after any of their corresponding longhand properties.",
  description="A paired-column chart with values for mobile (desktop is always within a percentage or two).  The results are: background 53%, margin 12%, font 12%, padding 8%, animation 4%, border-radius 3%, list-style 2%, flex 1%, overflow 1%, transition 1%, all others 3%",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRXMwdR5iy0KEMBzUWuZqDfWsj8HDDJcd5lFfjJpBmJr8gI1TE3xz2BzbNB9SEzSrxDtxfqvDvnvbQ3/pubchart?oid=288419798&format=interactive",
  height=388,
  sheets_gid="1352208996",
  sql_file="meta_longhand_first_properties.sql"
) }}



{{ figure_markup(
  image="most-popular-sass-function-calls.png",
  caption="The most commonly used Sass function calls.",
  description="A paired-column chart with values for mobile (desktop is always within a percentage or two).  The results are: (other) 18%, darken 16%, if 15%, map-get 10%, map-keys 9%, percentage 7%, nth 5%, lighten 5%, mix 4%, (alpha adjustment) 3%, length 3%, type-of 3%, unit 2%.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRXMwdR5iy0KEMBzUWuZqDfWsj8HDDJcd5lFfjJpBmJr8gI1TE3xz2BzbNB9SEzSrxDtxfqvDvnvbQ3/pubchart?oid=714529985&format=interactive",
  height=552,
  sheets_gid="400373190",
  sql_file="sass_function_calls.sql"
) }}



{{ figure_markup(
  image="usage-of-control-flow-statements-in-scss.png",
  caption="The most commonly used Sass flow control structures.",
  description="A paired-column chart with values for mobile (desktop is always within a percentage or two).  The results are: @if 66%, @for 58%, @each 58%, @while 2%.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRXMwdR5iy0KEMBzUWuZqDfWsj8HDDJcd5lFfjJpBmJr8gI1TE3xz2BzbNB9SEzSrxDtxfqvDvnvbQ3/pubchart?oid=438915471&format=interactive",
  sheets_gid="920758691",
  sql_file="sass_control_flow_statements.sql"
) }}



{{ figure_markup(
  image="usage-of-explicit-nesting-in-scss.png",
  caption="The prevalence of rule-nesting in Sass.",
  description="A paired-column chart with values for mobile (desktop is always within a percentage or two).  The results are: Total 87%, @:pseudo-class 85%, &.class 81%, &::pseudo-element 70%, & (by itself) 64%, $[attr] 59%, & > 27%, & + 26%, & descendant 18%, &#id 7%, & - 5%.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRXMwdR5iy0KEMBzUWuZqDfWsj8HDDJcd5lFfjJpBmJr8gI1TE3xz2BzbNB9SEzSrxDtxfqvDvnvbQ3/pubchart?oid=61926709&format=interactive",
  height=455,
  sheets_gid="1859409315",
  sql_file="sass_nesting.sql"
) }}
