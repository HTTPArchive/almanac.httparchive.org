---
#See https://github.com/HTTPArchive/almanac.httparchive.org/wiki/Authors'-Guide#metadata-to-add-at-the-top-of-your-chapters
part_number: I
chapter_number: 1
title: CSS
description: CSS chapter of the 2020 Web Almanac covering color, units, selectors, layout, typography and fonts, spacing, decoration, animation, and media queries.
authors: [LeaVerou, svgeesus, rachelandrew]
reviewers: [fantasai, mirisuzanne, j9t, catalinred, hankchizljaw]
analysts: [Tiggerito]
translators: []
#LeaVerou_bio: TODO
#svgeesus_bio: TODO
#rachelandrew_bio: TODO
discuss: 2037
results: https://docs.google.com/spreadsheets/d/1sMWXWjMujqfAREYxNbG_t1fOJKYCA6ASLwtz4pBQVTw/
queries: 01_CSS
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

## Methodology

## Usage

{{ figure_markup(
  image="stylesheet-size.png",
  caption="Distribution of the stylesheet transfer size per page.",
  description="Bar chart showing the distribution of stylesheet transfer size per page, which includes compression when enabled. Desktop tends to have slightly more stylesheet bytes per page by about 10 KB. The 10, 25, 50, 75, and 90th percentiles for mobile are: 5, 22, 56, 122, and 234 KB.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRpe_HsNGpekn6YZV9k6QGmcZPxalqnDrL7DrDY-7X65RZEf_-aGfWuEvhk-yWV83ctIceE1bppCLpj/pubchart?oid=762340058&format=interactive",
  sheets_gid="314594173",
  sql_file="stylesheet_kbytes.sql"
) }}

{{ figure_markup(
  image="stylesheet-count.png",
  caption="Distribution of the number of stylesheets per page.",
  description="Bar chart showing the distribution of stylesheets per page. Desktop and mobile are nearly equal throughout the distribution. The 10, 25, 50, 75, and 90th percentiles for mobile are: 1, 3, 6, 12, and 21 stylesheets per page.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRpe_HsNGpekn6YZV9k6QGmcZPxalqnDrL7DrDY-7X65RZEf_-aGfWuEvhk-yWV83ctIceE1bppCLpj/pubchart?oid=163217622&format=interactive",
  sheets_gid="1111507751",
  sql_file="stylesheet_count.sql"
) }}

{{ figure_markup(
  image="rules.png",
  caption="Distribution of the total number of style rules per page.",
  description="Bar chart showing the distribution of style rules per page. Mobile tends to have slightly more rules than desktop. The 10, 25, 50, 75, and 90th percentiles for mobile are: 13, 140, 479, 1,074, and 1,831 rules per page.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRpe_HsNGpekn6YZV9k6QGmcZPxalqnDrL7DrDY-7X65RZEf_-aGfWuEvhk-yWV83ctIceE1bppCLpj/pubchart?oid=1918103300&format=interactive",
  sheets_gid="42376523",
  sql_file="selectors.sql"
) }}

## Selectors and the cascade

{{ figure_markup(
  image="popular-class-names.png",
  caption="The most popular class names by the percent of pages.",
  description="Bar chart showing the top 14 most popular class names for desktop and mobile pages. The active class is found on 40% of pages. The rest of the classes are found on 20-30% of pages and are, in decreasing order: fa, fa-*, pull-right, pull-left, selected, disabled, clearfix, button, title, wp-*, btn, container, and sr-only.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRpe_HsNGpekn6YZV9k6QGmcZPxalqnDrL7DrDY-7X65RZEf_-aGfWuEvhk-yWV83ctIceE1bppCLpj/pubchart?oid=1187401149&format=interactive",
  sheets_gid="863628849",
  sql_file="top_selector_classes_wp_fa_prefixes.sql"
) }}

{{ figure_markup(
  image="popular-ids.png",
  caption="The most popular IDs by the percent of pages.",
  description="Bar chart showing the top 10 most popular IDs for desktop and mobile pages. The most popular ID is content at 14% of pages. The footer and header IDs have slightly smaller adoption. The logo, main, respond, comments, fancybox-loading, wrapper, and submit IDs have between 5 and 10% adoption on pages. The only notable difference between desktop and mobile is the comments ID used on about 8% of mobile pages but only 5% of desktop pages.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRpe_HsNGpekn6YZV9k6QGmcZPxalqnDrL7DrDY-7X65RZEf_-aGfWuEvhk-yWV83ctIceE1bppCLpj/pubchart?oid=141873739&format=interactive",
  sheets_gid="734822190",
  sql_file="top_selector_ids.sql"
) }}

{{ figure_markup(
  image="important-properties.png",
  caption="Distribution of the percent of `!important` properties per page.",
  description="Bar chart showing the distribution of the percent of !important properties per page. Desktop pages tend to use !important on slightly more properties than mobile. The 10, 25, 50, 75, and 90th percentiles for mobile are: 0, 1, 2, 4, and 7% of properties having !important.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRpe_HsNGpekn6YZV9k6QGmcZPxalqnDrL7DrDY-7X65RZEf_-aGfWuEvhk-yWV83ctIceE1bppCLpj/pubchart?oid=768784205&format=interactive",
  sheets_gid="1743048352",
  sql_file="meta_important_adoption.sql"
) }}

{{ figure_markup(
  image="important-top-properties.png",
  caption="The top `!important` properties by the percent of pages.",
  description="Bar chart showing the top 10 properties used with !important. Mobile and desktop have similar usage. The display property is used with !important the most, by 79% of mobile pages. In decreasing order, the subsequent properties on 71-58% of mobile pages are: color, width, height, background, padding, margin, border, background-color, and float.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRpe_HsNGpekn6YZV9k6QGmcZPxalqnDrL7DrDY-7X65RZEf_-aGfWuEvhk-yWV83ctIceE1bppCLpj/pubchart?oid=257343566&format=interactive",
  sheets_gid="1222608982",
  sql_file="meta_important_properties.sql"
) }}

<figure markdown>
Percentile | Desktop | Mobile
-- | -- | --
10 | 0,1,0 | 0,1,0
25 | 0,2,0 | 0,1,2
50 | 0,2,0 | 0,2,0
75 | 0,2,0 | 0,2,0
90 | 0,3,0 | 0,3,0

  <figcaption>
    {{ figure_link(
      caption="Distribution of the median specificity per page.",
      sheets_gid="1213836297",
      sql_file="specificity.sql"
    ) }}
  </figcaption>
</figure>

{{ figure_markup(
  image="attribute-selectors.png",
  caption="The most popular attribute selectors by the percent of pages.",
  description="Bar chart showing the top attribute selectors by the percent of pages. Mobile and desktop have similar usage. The most popular attribute selector by far is type, used on 46% of mobile pages. Next, the class attribute selector is used on 30% of mobile pages. The following attribute selectors are used on between 17 and 3% in descending order: disabled, dir, title, hidden, controls, data-type, data-align, href, poster, role, style, xmlns, aria-disabled, src, id, name, lang, and multiple.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRpe_HsNGpekn6YZV9k6QGmcZPxalqnDrL7DrDY-7X65RZEf_-aGfWuEvhk-yWV83ctIceE1bppCLpj/pubchart?oid=320159317&format=interactive",
  sheets_gid="1926527049",
  sql_file="top_selector_attributes.sql"
) }}

{{ figure_markup(
  image="selector-pseudo-classes.png",
  caption="Usage of legacy `:pseudo-class` syntax for `::pseudo-elements` as a percent of mobile pages.",
  description="Bar chart showing the percent of pages that use pseudo-class syntax (prefixed by one colon) versus pseudo-element syntax (two colons) for pseudo-elements. The before pseudo-element is used with pseudo-class syntx on 71% of mobile pages and pseudo-element syntax on 33% of mobile pages. The after pseudo-element is used with class and element syntax on 68% and 30% of mobile pages, first-letter on 7% and 1% of mobile pages, and first-line on 1% and 0% of mobile pages.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRpe_HsNGpekn6YZV9k6QGmcZPxalqnDrL7DrDY-7X65RZEf_-aGfWuEvhk-yWV83ctIceE1bppCLpj/pubchart?oid=227968207&format=interactive",
  sheets_gid="2029589646",
  sql_file="top_selector_pseudo_classes.sql"
) }}

{{ figure_markup(
  image="popular-selector-pseudo-classes.png",
  caption="The most popular pseudo-classes as a percent of pages.",
  description="Bar chart showing the most popular pseudo-classes as a percent of pages for desktop and mobile. Desktop and mobile are mostly similar, with mobile tending to have slightly higher adoption. The most popular pseudo-class is hover, used on 84% of pages. The following pseudo-classes decrease in popularity from 71% to 12% almost linearly: before, after, focus, active, first-child, last-child, visited, not, root, nth-child, link, disabled, empty, nth-of-type.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRpe_HsNGpekn6YZV9k6QGmcZPxalqnDrL7DrDY-7X65RZEf_-aGfWuEvhk-yWV83ctIceE1bppCLpj/pubchart?oid=1363774711&format=interactive",
  sheets_gid="2029589646",
  sql_file="top_selector_pseudo_classes.sql"
) }}

{{ figure_markup(
  image="popular-selector-pseudo-elements.png",
  caption="The most popular pseudo-elements as a percent of pages.",
  description="Bar chart showing the most popular pseudo-elements as a percent of pages for desktop and mobile. Desktop and mobile are mostly similar, with mobile tending to have slightly higher adoption. The most popular pseudo-element is before, used on 33% of mobile pages. The after pseudo-element is used on 30% of mobile pages. -moz-focus-inner is unsed on 24% of pages. The popularity drops after those from 17% to 4% in decreasing order: -webkit-input-placeholder, -moz-placeholder, -webkit-search-decoration, -webkit-search-cancel-button, -webkit-inner-spin-button, -webkit-outer-spin-button, -webkit-scrollbar (7%), selection, -ms-clear, -moz-selection, -webkit-media-controls, and -webkit-scrollbar-thumb.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRpe_HsNGpekn6YZV9k6QGmcZPxalqnDrL7DrDY-7X65RZEf_-aGfWuEvhk-yWV83ctIceE1bppCLpj/pubchart?oid=1417577353&format=interactive",
  sheets_gid="1972610663",
  sql_file="top_selector_pseudo_elements.sql",
  width=600,
  height=500
) }}

## Values and units

### Lengths

{{ figure_markup(
  caption="Percentage of `<length>` values that use the `px` unit.",
  content="72.58%",
  classes="big-number",
  sheets_gid="1221511608",
  sql_file="units_frequency.sql"
) }}

{{ figure_markup(
  image="length-units.png",
  caption="The most popular `<length>` units as a percent of occurrences.",
  description="Bar chart showing the most popular length units as a percent of occurrences (the frequency that the units appear in all stylesheets). The px unit is by far the most popular, used 73% of the time in mobile stylesheets. The next most popular unit is % (percent sign), at 17%, followed by em at 9%, and rem at 1%. The following units all have usage so low that they round to 0%: pt, vw, vh, ch, ex, cm, mm, in, vmin, pc, and vmax.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRpe_HsNGpekn6YZV9k6QGmcZPxalqnDrL7DrDY-7X65RZEf_-aGfWuEvhk-yWV83ctIceE1bppCLpj/pubchart?oid=2095127496&format=interactive",
  sheets_gid="1221511608",
  sql_file="units_frequency.sql"
) }}

<figure>
  <table>
    <thead>
      <tr>
        <th>Property</th>
        <th><code>px</code></th>
        <th><code>&lt;number&gt;</code></th>
        <th><code>em</code></th>
        <th><code>%</code></th>
        <th><code>rem</code></th>
        <th><code>pt</code></th>
      </tr>
    </thead>
    <tbody>
      <tr>
        <td>font-size</td>
        <td class="numeric">70%</td>
        <td class="numeric">2%</td>
        <td class="numeric">17%</td>
        <td class="numeric">6%</td>
        <td class="numeric">4%</td>
        <td class="numeric">2%</td>
      </tr>
      <tr>
        <td>line-height</td>
        <td class="numeric">54%</td>
        <td class="numeric">31%</td>
        <td class="numeric">13%</td>
        <td class="numeric">3%</td>
        <td></td>
        <td></td>
      </tr>
      <tr>
        <td>border</td>
        <td class="numeric">71%</td>
        <td class="numeric">27%</td>
        <td class="numeric">2%</td>
        <td></td>
        <td></td>
        <td></td>
      </tr>
      <tr>
        <td>border-radius</td>
        <td class="numeric">65%</td>
        <td class="numeric">21%</td>
        <td class="numeric">3%</td>
        <td class="numeric">10%</td>
        <td></td>
        <td></td>
      </tr>
      <tr>
        <td>text-indent</td>
        <td class="numeric">32%</td>
        <td class="numeric">51%</td>
        <td class="numeric">8%</td>
        <td class="numeric">9%</td>
        <td></td>
        <td></td>
      </tr>
      <tr>
        <td>vertical-align</td>
        <td class="numeric">29%</td>
        <td class="numeric">12%</td>
        <td class="numeric">55%</td>
        <td class="numeric">4%</td>
        <td></td>
        <td></td>
      </tr>
      <tr>
        <td>mask-position</td>
        <td></td>
        <td></td>
        <td class="numeric">50%</td>
        <td class="numeric">50%</td>
        <td></td>
        <td></td>
      </tr>
      <tr>
        <td>padding-inline-start</td>
        <td class="numeric">33%</td>
        <td class="numeric">5%</td>
        <td class="numeric">62%</td>
        <td></td>
        <td></td>
        <td></td>
      </tr>
      <tr>
        <td>gap</td>
        <td class="numeric">21%</td>
        <td class="numeric">16%</td>
        <td class="numeric">1%</td>
        <td></td>
        <td class="numeric">62%</td>
        <td></td>
      </tr>
      <tr>
        <td>margin-block-end</td>
        <td class="numeric">4%</td>
        <td class="numeric">31%</td>
        <td class="numeric">65%</td>
        <td></td>
        <td></td>
        <td></td>
      </tr>
      <tr>
        <td>margin-inline-start</td>
        <td class="numeric">38%</td>
        <td class="numeric">46%</td>
        <td class="numeric">14%</td>
        <td></td>
        <td class="numeric">1%</td>
        <td></td>
      </tr>
    </tbody>
  </table>
  <figcaption>
    {{ figure_link(
      caption="Unit usage by property.",
      sheets_gid="1200981062",
      sql_file="units_properties.sql"
    ) }}
  </figcaption>
</figure>

{{ figure_markup(
  image="font-units.png",
  caption="Relative popularity of font-based units other than `px` as a percent of occurrences.",
  description="Bar chart showing the relative popularity of font-based units other than px. em is used overwhelmingly on 87.3% of instances, followed by rem at 12.2, ch at 0.4%, and ex at 0.2% of instances on mobile pages.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRpe_HsNGpekn6YZV9k6QGmcZPxalqnDrL7DrDY-7X65RZEf_-aGfWuEvhk-yWV83ctIceE1bppCLpj/pubchart?oid=166603845&format=interactive",
  sheets_gid="1221511608",
  sql_file="units_frequency.sql"
) }}

{{ figure_markup(
  image="zero-lengths.png",
  caption="Relative popularity of 0 lengths by unit as a percent of occurrences on mobile pages.",
  description="Pie chart showing 0 lengths with no unit (AKA unitless) used 88.7% of the time on mobile pages, the px unit at 10.7%, and other units on 0.5% of instances.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRpe_HsNGpekn6YZV9k6QGmcZPxalqnDrL7DrDY-7X65RZEf_-aGfWuEvhk-yWV83ctIceE1bppCLpj/pubchart?oid=1935151776&format=interactive",
  sheets_gid="313150061",
  sql_file="units_zero.sql"
) }}

### Calculations

{{ figure_markup(
  image="calc-properties.png",
  caption="Relative popularity of properties that use `calc()` as a percent of occurrences.",
  description="Bar chart showing the relative popularity of properties that use the calc function as a percent of occurrences. Desktop and mobile have similar results. The calc function is used most often on the width property, 59% of calc occurrences on mobile pages. It's used on the left property 11% of the time, top 5%, max-width 4%, height 4%, and the remaining properties are decreasing at 2% and 1%: min-height, margin-left, flex-basis, margin-right, max-height (1%), right, padding-bottom, padding-left, font-size, and padding-right.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRpe_HsNGpekn6YZV9k6QGmcZPxalqnDrL7DrDY-7X65RZEf_-aGfWuEvhk-yWV83ctIceE1bppCLpj/pubchart?oid=722318406&format=interactive",
  sheets_gid="1661677319",
  sql_file="calc_properties.sql"
) }}

{{ figure_markup(
  image="calc-units.png",
  caption="Relative popularity of units that use `calc()` as a percent of occurrences.",
  description="Bar chart showing the relative popularity of properties that use the calc function as a percent of occurrences. Desktop and mobile have similar results. The calc function is used most often on the width property, 59% of calc occurrences on mobile pages. It's used on the left property 11% of the time, top 5%, max-width 4%, height 4%, and the remaining properties are decreasing at 2% and 1%: min-height, margin-left, flex-basis, margin-right, max-height (1%), right, padding-bottom, padding-left, font-size, and padding-right.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRpe_HsNGpekn6YZV9k6QGmcZPxalqnDrL7DrDY-7X65RZEf_-aGfWuEvhk-yWV83ctIceE1bppCLpj/pubchart?oid=477094785&format=interactive",
  sheets_gid="769910871",
  sql_file="calc_units.sql"
) }}

{{ figure_markup(
  image="calc-operators.png",
  caption="Relative popularity of operators that use `calc()` as a percent of occurrences.",
  description="Bar chart showing the relative popularity of operators that use the calc function as a percent of occurrences. Desktop and mobile have similar results. The calc function is used most often with the subtraction operator (minus sign), 64% of calc instances on mobile pages, followed by division (forward slash) 20%, addition (plus sign) 11%, and multiplication (asterisk) 5%.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRpe_HsNGpekn6YZV9k6QGmcZPxalqnDrL7DrDY-7X65RZEf_-aGfWuEvhk-yWV83ctIceE1bppCLpj/pubchart?oid=1909242522&format=interactive",
  sheets_gid="2077258816",
  sql_file="calc_operators.sql"
) }}

{# TODO(analysts): Figure out what happened to the 3+ label in this chart. #}
{{ figure_markup(
  image="calc-complexity-units.png",
  caption="Distribution of the number of units per `calc()` occurrence.",
  description="Bar chart showing the distribution of the number of units per calc function occurrence. Desktop and mobile have similar results. Calc is used with one unit 11% of the time on mobile pages, twice 89% of the time, and 3 or more times approximately 0% of the time.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRpe_HsNGpekn6YZV9k6QGmcZPxalqnDrL7DrDY-7X65RZEf_-aGfWuEvhk-yWV83ctIceE1bppCLpj/pubchart?oid=695698141&format=interactive",
  sheets_gid="1493602565",
  sql_file="calc_complexity_units.sql"
) }}

### Global keywords and `all`

{{ figure_markup(
  image="keyword-totals.png",
  caption="Adoption of global keywords as a percent of pages.",
  description="Bar chart showing the adoption of global keywords as a percent of pages. Mobile pages tend to have a higher adoption rate. The inherit keyword is used on 85% of mobile pages, initial on 51%, unset on 43%, and revert on approximately 0%.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRpe_HsNGpekn6YZV9k6QGmcZPxalqnDrL7DrDY-7X65RZEf_-aGfWuEvhk-yWV83ctIceE1bppCLpj/pubchart?oid=1246886332&format=interactive",
  sheets_gid="437371205",
  sql_file="keyword_totals.sql"
) }}

## Color

{{ figure_markup(
  image="popular-color-formats.png",
  caption="Relative popularity of color formats as a percent of occurrences.",
  description="Bar chart showing the relative popularity of color formats as a percent of occurrences. The #rrggbb color format is used in 50% of occurrences on mobile pages, with desktop slightly higher at 52%. The #rgb format is used in 25% of occurrences, followed by rgba() at 14%, transparent at 8%, a named color (like red) at 1%, and the remaining color formats all have approximately 0% relative popularity on mobile pages: #rrggbbaa, rbg(), hsla(), currentColor, #rgba, a system color, hsl(), and color().",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRpe_HsNGpekn6YZV9k6QGmcZPxalqnDrL7DrDY-7X65RZEf_-aGfWuEvhk-yWV83ctIceE1bppCLpj/pubchart?oid=65722098&format=interactive",
  sheets_gid="366025718",
  sql_file="color_formats.sql"
) }}

{{ figure_markup(
  image="color-formats-alpha.png",
  caption="Relative popularity of color formats grouped by alpha support as a percent of occurrences on mobile pages (excluding `#rrggbb` and `#rgb`).",
  description="Bar chart showing the relative popularity of color formats grouped by alpha support as a percent of occurrences on mobile pages, excluding #rrggbb and #rgb. Color formats that support alpha add up to about 23% of occurrences, while color formats that do not support alpha add up to only 2% of occurrences on mobile pages.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRpe_HsNGpekn6YZV9k6QGmcZPxalqnDrL7DrDY-7X65RZEf_-aGfWuEvhk-yWV83ctIceE1bppCLpj/pubchart?oid=1861989753&format=interactive",
  sheets_gid="366025718",
  sql_file="color_formats.sql"
) }}

{# TODO(analysts, CSS experts): figure out why the swatches aren't working. #}
<figure>
  <table>
    <thead>
      <tr>
        <th></th>
        <th>Keyword</th>
        <th>Desktop</th>
        <th>Mobile</th>
      </tr>
    </thead>
    <tbody>
      <tr>
        <td><span class="color-swatch" style="background-color: transparent"></span></td>
        <td>transparent</td>
        <td class="numeric">84.04%</td>
        <td class="numeric">83.51%</td>
      </tr>
      <tr>
        <td><span class="color-swatch" style="background-color: white"></span></td>
        <td>white</td>
        <td class="numeric">6.82%</td>
        <td class="numeric">7.34%</td>
      </tr>
      <tr>
        <td><span class="color-swatch" style="background-color: black"></span></td>
        <td>black</td>
        <td class="numeric">2.32%</td>
        <td class="numeric">2.42%</td>
      </tr>
      <tr>
        <td><span class="color-swatch" style="background-color: red"></span></td>
        <td>red</td>
        <td class="numeric">2.03%</td>
        <td class="numeric">2.01%</td>
      </tr>
      <tr>
        <td><span class="color-swatch" style="background-color: currentColor"></span></td>
        <td>currentColor</td>
        <td class="numeric">1.43%</td>
        <td class="numeric">1.43%</td>
      </tr>
      <tr>
        <td><span class="color-swatch" style="background-color: gray"></span></td>
        <td>gray</td>
        <td class="numeric">0.75%</td>
        <td class="numeric">0.79%</td>
      </tr>
      <tr>
        <td><span class="color-swatch" style="background-color: silver"></span></td>
        <td>silver</td>
        <td class="numeric">0.66%</td>
        <td class="numeric">0.58%</td>
      </tr>
      <tr>
        <td><span class="color-swatch" style="background-color: grey"></span></td>
        <td>grey</td>
        <td class="numeric">0.35%</td>
        <td class="numeric">0.31%</td>
      </tr>
      <tr>
        <td><span class="color-swatch" style="background-color: green"></span></td>
        <td>green</td>
        <td class="numeric">0.36%</td>
        <td class="numeric">0.30%</td>
      </tr>
      <tr>
        <td><span class="color-swatch" style="background-color: magenta"></span></td>
        <td>magenta</td>
        <td class="numeric">0.00%</td>
        <td class="numeric">0.13%</td>
      </tr>
      <tr>
        <td><span class="color-swatch" style="background-color: blue"></span></td>
        <td>blue</td>
        <td class="numeric">0.16%</td>
        <td class="numeric">0.13%</td>
      </tr>
      <tr>
        <td><span class="color-swatch" style="background-color: whitesmoke"></span></td>
        <td>whitesmoke</td>
        <td class="numeric">0.17%</td>
        <td class="numeric">0.12%</td>
      </tr>
      <tr>
        <td><span class="color-swatch" style="background-color: lightgray"></span></td>
        <td>lightgray</td>
        <td class="numeric">0.06%</td>
        <td class="numeric">0.11%</td>
      </tr>
      <tr>
        <td><span class="color-swatch" style="background-color: orange"></span></td>
        <td>orange</td>
        <td class="numeric">0.12%</td>
        <td class="numeric">0.10%</td>
      </tr>
      <tr>
        <td><span class="color-swatch" style="background-color: lightgrey"></span></td>
        <td>lightgrey</td>
        <td class="numeric">0.04%</td>
        <td class="numeric">0.10%</td>
      </tr>
      <tr>
        <td><span class="color-swatch" style="background-color: yellow"></span></td>
        <td>yellow</td>
        <td class="numeric">0.08%</td>
        <td class="numeric">0.06%</td>
      </tr>
      <tr>
        <td><span class="color-swatch" style="background-color: Highlight"></span></td>
        <td>Highlight</td>
        <td class="numeric">0.01%</td>
        <td class="numeric">0.04%</td>
      </tr>
      <tr>
        <td><span class="color-swatch" style="background-color: gold"></span></td>
        <td>gold</td>
        <td class="numeric">0.04%</td>
        <td class="numeric">0.04%</td>
      </tr>
      <tr>
        <td><span class="color-swatch" style="background-color: pink"></span></td>
        <td>pink</td>
        <td class="numeric">0.03%</td>
        <td class="numeric">0.03%</td>
      </tr>
      <tr>
        <td><span class="color-swatch" style="background-color: teal"></span></td>
        <td>teal</td>
        <td class="numeric">0.03%</td>
        <td class="numeric">0.02%</td>
      </tr>
    </tbody>
  </table>
  <figcaption>
    {{ figure_link(
      caption="Relative popularity of color keywords as a percent of occurrences.",
      sheets_gid="1429541094",
      sql_file="color_keywords.sql"
    ) }}
  </figcaption>
</figure>

<figure>
  <table>
    <thead>
      <tr>
        <th>sRGB</th>
        <th></th>
        <th><code>display-p3</code></th>
        <th>ΔE2000</th>
        <th>In gamut</th>
      </tr>
    </thead>
    <tbody>
      <tr>
        <td><code>rgba(0,0,0,1)</code></td>
        <td style="background-color: rgba(0, 0, 0, 1)"></td>
        <td><code>color(display-p3 0 0 0 / 1)</code></td>
        <td>0.000</td>
        <td>true</td>
      </tr>
      <tr>
        <td><code>rgba(255,255,255,1)</code></td>
        <td style="background-color: rgba(255, 255, 255, 1)"></td>
        <td><code>color(display-p3 1 1 1 / 1)</code></td>
        <td>0.015</td>
        <td>false</td>
      </tr>
      <tr>
        <td><code>rgba(200,200,200,1)</code></td>
        <td style="background-color: rgba(200, 200, 200, 1)"></td>
        <td><code>color(display-p3 0.78 0.78 0.78 / 1)</code></td>
        <td>0.274</td>
        <td>true</td>
      </tr>
      <tr>
        <td><code>rgba(121,127,132,1)</code></td>
        <td style="background-color: rgba(121, 127, 132, 1)"></td>
        <td><code>color(display-p3 0.48 0.50 0.52 / 1)</code></td>
        <td>0.391</td>
        <td>true</td>
      </tr>
      <tr>
        <td><code>rgba(255,205,63,1)</code></td>
        <td style="background-color: rgba(255, 205, 63, 1)"></td>
        <td><code>color(display-p3 1 0.80 0.25 / 1)</code></td>
        <td>3.880</td>
        <td>false</td>
      </tr>
      <tr>
        <td><code>rgba(241,174,50,1)</code></td>
        <td style="background-color: rgba(241, 174, 50, 1)"></td>
        <td><code>color(display-p3 0.95 0.68 0.17 / 1)</code></td>
        <td>4.701</td>
        <td>false</td>
      </tr>
      <tr>
        <td><code>rgba(245,181,40,1)</code></td>
        <td style="background-color: rgba(245, 181, 40, 1)"></td>
        <td><code>color(display-p3 0.96 0.71 0.16 / 1)</code></td>
        <td>4.218</td>
        <td>false</td>
      </tr>
      <tr>
        <td><code>rgb(147, 83, 255)</code></td>
        <td style="background-color: rgb(147, 83, 255)"></td>
        <td><code>color(display-p3 0.58 0.33 1 / 1)</code></td>
        <td>2.143</td>
        <td>false</td>
      </tr>
      <tr>
        <td><code>rgba(120,0,255,1)</code></td>
        <td style="background-color: rgba(120, 0, 255, 1)"></td>
        <td><code>color(display-p3 0.47 0 1 / 1)</code></td>
        <td>1.933</td>
        <td>false</td>
      </tr>
      <tr>
        <td><code>rgba(75,3,161,1)</code></td>
        <td style="background-color: rgba(75, 3, 161, 1)"></td>
        <td><code>color(display-p3 0.29 0.01 0.63 / 1)</code></td>
        <td>1.321</td>
        <td>false</td>
      </tr>
      <tr>
        <td><code>rgba(255,0,0,0.85)</code></td>
        <td style="background-color: rgba(255, 0, 0, 0.85)"></td>
        <td><code>color(display-p3 1 0 0 / 0.85)</code></td>
        <td>7.115</td>
        <td>false</td>
      </tr>
      <tr>
        <td><code>rgba(84,64,135,1)</code></td>
        <td style="background-color: rgba(84, 64, 135, 1)"></td>
        <td><code>color(display-p3 0.33 0.25 0.53 / 1)</code></td>
        <td>1.326</td>
        <td>true</td>
      </tr>
      <tr>
        <td><code>rgba(131,103,201,1)</code></td>
        <td style="background-color: rgba(131, 103, 201, 1)"></td>
        <td><code>color(display-p3 0.51 0.40 0.78 / 1)</code></td>
        <td>1.348</td>
        <td>true</td>
      </tr>
      <tr>
        <td><code>rgba(68,185,208,1)</code></td>
        <td style="background-color: rgba(68, 185, 208, 1)"></td>
        <td><code>color(display-p3 0.27 0.75 0.82 / 1)</code></td>
        <td>5.591</td>
        <td>false</td>
      </tr>
      <tr>
        <td><code>rgb(255,0,72)</code></td>
        <td style="background-color: rgb(255, 0, 72)"></td>
        <td><code>color(display-p3 1 0 0.2823 / 1)</code></td>
        <td>3.529</td>
        <td>false</td>
      </tr>
      <tr>
        <td><code>#fffc00</code></td>
        <td style="background-color: #fffc00"></td>
        <td><code>color(display-p3 1 0.9882 0)</code></td>
        <td>5.012</td>
        <td>false</td>
      </tr>
      <tr>
        <td><code>#6d3bff</code></td>
        <td style="background-color: #6d3bff"></td>
        <td><code>color(display-p3 .427 .231 1)</code></td>
        <td>1.584</td>
        <td>false</td>
      </tr>
      <tr>
        <td><code>#03d658</code></td>
        <td style="background-color: #03d658"></td>
        <td><code>color(display-p3 .012 .839 .345)</code></td>
        <td>4.958</td>
        <td>false</td>
      </tr>
      <tr>
        <td><code>#ff3900</code></td>
        <td style="background-color: #ff3900"></td>
        <td><code>color(display-p3 1 .224 0)</code></td>
        <td>7.140</td>
        <td>false</td>
      </tr>
      <tr>
        <td><code>#7cf8b3</code></td>
        <td style="background-color: #7cf8b3"></td>
        <td><code>color(display-p3 .486 .973 .702)</code></td>
        <td>4.284</td>
        <td>true</td>
      </tr>
      <tr>
        <td><code>#f8f8f8</code></td>
        <td style="background-color: #f8f8f8"></td>
        <td><code>color(display-p3 .973 .973 .973)</code></td>
        <td>0.028</td>
        <td>true</td>
      </tr>
      <tr>
        <td><code>#e3f5fd</code></td>
        <td style="background-color: #e3f5fd"></td>
        <td><code>color(display-p3 .875 .945 .976)</code></td>
        <td>1.918</td>
        <td>true</td>
      </tr>
      <tr>
        <td><code>#e74832</code></td>
        <td style="background-color: #e74832"></td>
        <td><code>color( display-p3 .905882353 .282352941 .196078431 / 1 )</code></td>
        <td>3.681</td>
        <td>true</td>
      </tr>
    </tbody>
  </table>
  <figcaption>
    {{ figure_link(
      caption="The fallback sRGB colors and <code>display-p3</code> colors.<br>A color difference (ΔE2000) of 1 is barely visible, while 5 is clearly distinct."
    ) }}
  </figcaption>
</figure>

{{ figure_markup(
  image="UCS-p3-pairs.svg",
  caption="1976 u’v’ diagram of the chromaticity of colors.",
  description="This 1976 u’v’ diagram shows the chromaticity of colors (flattened to 2D, so lightness is not shown). The outer curved shape represents the spectrum of pure single wavelengths; there are no visible colors outside this. The straight line is purple, a mixture of red and violet. The smaller, grey, triangle is the sRGB gamut while the larger, darker triangle is the display-p3 gamut. The 23 unique display-p3 colors actually in use on the web in 2020 are shown; for each pair of colors the larger circle is the sRGB fallback while the smaller circle is the display-p3 color. If it is inside the sRGB gamut, those circles show the correct color. Otherwise, a white circle with a red edge indicates out of sRGB-gamut colors.",
  width=600,
  height=600
) }}

## Gradients

## Layout

### Flexbox and Grid adoption

### Usage of different Grid layout techniques

### Multiple-column layout

### Box sizing

## Transitions and animations

## Visual effects

### Blend modes

### Filters

### Masks

### Clipping paths

## Responsive design

### Which media features are people using?

### Common breakpoints

### Properties used inside media queries

## Custom properties

### Naming

### Usage by type

### Complexity

## CSS and JS

### Houdini

### CSS-in-JS

## Internationalization

### Direction

### Logical vs physical properties

## Browser support

### Vendor prefixes

### Feature queries

## Meta

### Declaration repetition

### Shorthands and longhands

#### Shorthands before longhands

#### font

#### background

#### Margins and paddings

#### Flex

#### Grid

### CSS mistakes

#### Syntax errors

#### Nonexistent properties

#### Longhands before shorthands

## Sass

## Conclusion
