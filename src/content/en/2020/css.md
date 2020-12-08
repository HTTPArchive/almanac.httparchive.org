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
        <td>{{ swatch('transparent') }}</span></td>
        <td>transparent</td>
        <td class="numeric">84.04%</td>
        <td class="numeric">83.51%</td>
      </tr>
      <tr>
        <td>{{ swatch('white') }}</td>
        <td>white</td>
        <td class="numeric">6.82%</td>
        <td class="numeric">7.34%</td>
      </tr>
      <tr>
        <td>{{ swatch('black') }}</span></td>
        <td>black</td>
        <td class="numeric">2.32%</td>
        <td class="numeric">2.42%</td>
      </tr>
      <tr>
        <td>{{ swatch('red') }}</td>
        <td>red</td>
        <td class="numeric">2.03%</td>
        <td class="numeric">2.01%</td>
      </tr>
      <tr>
        <td>{{ swatch('currentColor') }}</span></td>
        <td>currentColor</td>
        <td class="numeric">1.43%</td>
        <td class="numeric">1.43%</td>
      </tr>
      <tr>
        <td>{{ swatch('gray') }}</span></td>
        <td>gray</td>
        <td class="numeric">0.75%</td>
        <td class="numeric">0.79%</td>
      </tr>
      <tr>
        <td>{{ swatch('silver') }}</span></td>
        <td>silver</td>
        <td class="numeric">0.66%</td>
        <td class="numeric">0.58%</td>
      </tr>
      <tr>
        <td>{{ swatch('grey') }}</span></td>
        <td>grey</td>
        <td class="numeric">0.35%</td>
        <td class="numeric">0.31%</td>
      </tr>
      <tr>
        <td>{{ swatch('green') }}</span></td>
        <td>green</td>
        <td class="numeric">0.36%</td>
        <td class="numeric">0.30%</td>
      </tr>
      <tr>
        <td>{{ swatch('magenta') }}</span></td>
        <td>magenta</td>
        <td class="numeric">0.00%</td>
        <td class="numeric">0.13%</td>
      </tr>
      <tr>
        <td>{{ swatch('blue') }}</span></td>
        <td>blue</td>
        <td class="numeric">0.16%</td>
        <td class="numeric">0.13%</td>
      </tr>
      <tr>
        <td>{{ swatch('whitesmoke') }}</span></td>
        <td>whitesmoke</td>
        <td class="numeric">0.17%</td>
        <td class="numeric">0.12%</td>
      </tr>
      <tr>
        <td>{{ swatch('lightgray') }}</span></td>
        <td>lightgray</td>
        <td class="numeric">0.06%</td>
        <td class="numeric">0.11%</td>
      </tr>
      <tr>
        <td>{{ swatch('orange') }}</span></td>
        <td>orange</td>
        <td class="numeric">0.12%</td>
        <td class="numeric">0.10%</td>
      </tr>
      <tr>
        <td>{{ swatch('lightgrey') }}</span></td>
        <td>lightgrey</td>
        <td class="numeric">0.04%</td>
        <td class="numeric">0.10%</td>
      </tr>
      <tr>
        <td>{{ swatch('yellow') }}</span></td>
        <td>yellow</td>
        <td class="numeric">0.08%</td>
        <td class="numeric">0.06%</td>
      </tr>
      <tr>
        <td>{{ swatch('Highlight') }}</span></td>
        <td>Highlight</td>
        <td class="numeric">0.01%</td>
        <td class="numeric">0.04%</td>
      </tr>
      <tr>
        <td>{{ swatch('gold') }}</span></td>
        <td>gold</td>
        <td class="numeric">0.04%</td>
        <td class="numeric">0.04%</td>
      </tr>
      <tr>
        <td>{{ swatch('pink') }}</span></td>
        <td>pink</td>
        <td class="numeric">0.03%</td>
        <td class="numeric">0.03%</td>
      </tr>
      <tr>
        <td>{{ swatch('teal') }}</span></td>
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
        <td>{{ swatch('rgba(0, 0, 0, 1)') }}</td>
        <td><code>color(display-p3 0 0 0 / 1)</code></td>
        <td>0.000</td>
        <td>true</td>
      </tr>
      <tr>
        <td><code>rgba(255,255,255,1)</code></td>
        <td>{{ swatch('rgba(255, 255, 255, 1)') }}</td>
        <td><code>color(display-p3 1 1 1 / 1)</code></td>
        <td>0.015</td>
        <td>false</td>
      </tr>
      <tr>
        <td><code>rgba(200,200,200,1)</code></td>
        <td>{{ swatch('rgba(200, 200, 200, 1)') }}</td>
        <td><code>color(display-p3 0.78 0.78 0.78 / 1)</code></td>
        <td>0.274</td>
        <td>true</td>
      </tr>
      <tr>
        <td><code>rgba(121,127,132,1)</code></td>
        <td>{{ swatch('rgba(121, 127, 132, 1)') }}</td>
        <td><code>color(display-p3 0.48 0.50 0.52 / 1)</code></td>
        <td>0.391</td>
        <td>true</td>
      </tr>
      <tr>
        <td><code>rgba(255,205,63,1)</code></td>
        <td>{{ swatch('rgba(255, 205, 63, 1)') }}</td>
        <td><code>color(display-p3 1 0.80 0.25 / 1)</code></td>
        <td>3.880</td>
        <td>false</td>
      </tr>
      <tr>
        <td><code>rgba(241,174,50,1)</code></td>
        <td>{{ swatch('rgba(241, 174, 50, 1)') }}</td>
        <td><code>color(display-p3 0.95 0.68 0.17 / 1)</code></td>
        <td>4.701</td>
        <td>false</td>
      </tr>
      <tr>
        <td><code>rgba(245,181,40,1)</code></td>
        <td>{{ swatch('rgba(245, 181, 40, 1)') }}</td>
        <td><code>color(display-p3 0.96 0.71 0.16 / 1)</code></td>
        <td>4.218</td>
        <td>false</td>
      </tr>
      <tr>
        <td><code>rgb(147, 83, 255)</code></td>
        <td>{{ swatch('rgb(147, 83, 255)') }}</td>
        <td><code>color(display-p3 0.58 0.33 1 / 1)</code></td>
        <td>2.143</td>
        <td>false</td>
      </tr>
      <tr>
        <td><code>rgba(120,0,255,1)</code></td>
        <td>{{ swatch('rgba(120, 0, 255, 1)') }}</td>
        <td><code>color(display-p3 0.47 0 1 / 1)</code></td>
        <td>1.933</td>
        <td>false</td>
      </tr>
      <tr>
        <td><code>rgba(75,3,161,1)</code></td>
        <td>{{ swatch('rgba(75, 3, 161, 1)') }}</td>
        <td><code>color(display-p3 0.29 0.01 0.63 / 1)</code></td>
        <td>1.321</td>
        <td>false</td>
      </tr>
      <tr>
        <td><code>rgba(255,0,0,0.85)</code></td>
        <td>{{ swatch('rgba(255, 0, 0, 0.85)') }}</td>
        <td><code>color(display-p3 1 0 0 / 0.85)</code></td>
        <td>7.115</td>
        <td>false</td>
      </tr>
      <tr>
        <td><code>rgba(84,64,135,1)</code></td>
        <td>{{ swatch('rgba(84, 64, 135, 1)') }}</td>
        <td><code>color(display-p3 0.33 0.25 0.53 / 1)</code></td>
        <td>1.326</td>
        <td>true</td>
      </tr>
      <tr>
        <td><code>rgba(131,103,201,1)</code></td>
        <td>{{ swatch('rgba(131, 103, 201, 1)') }}</td>
        <td><code>color(display-p3 0.51 0.40 0.78 / 1)</code></td>
        <td>1.348</td>
        <td>true</td>
      </tr>
      <tr>
        <td><code>rgba(68,185,208,1)</code></td>
        <td>{{ swatch('rgba(68, 185, 208, 1)') }}</td>
        <td><code>color(display-p3 0.27 0.75 0.82 / 1)</code></td>
        <td>5.591</td>
        <td>false</td>
      </tr>
      <tr>
        <td><code>rgb(255,0,72)</code></td>
        <td>{{ swatch('rgb(255, 0, 72)') }}</td>
        <td><code>color(display-p3 1 0 0.2823 / 1)</code></td>
        <td>3.529</td>
        <td>false</td>
      </tr>
      <tr>
        <td><code>#fffc00</code></td>
        <td>{{ swatch('#fffc00') }}</td>
        <td><code>color(display-p3 1 0.9882 0)</code></td>
        <td>5.012</td>
        <td>false</td>
      </tr>
      <tr>
        <td><code>#6d3bff</code></td>
        <td>{{ swatch('#6d3bff') }}</td>
        <td><code>color(display-p3 .427 .231 1)</code></td>
        <td>1.584</td>
        <td>false</td>
      </tr>
      <tr>
        <td><code>#03d658</code></td>
        <td>{{ swatch('#03d658') }}</td>
        <td><code>color(display-p3 .012 .839 .345)</code></td>
        <td>4.958</td>
        <td>false</td>
      </tr>
      <tr>
        <td><code>#ff3900</code></td>
        <td>{{ swatch('#ff3900') }}</td>
        <td><code>color(display-p3 1 .224 0)</code></td>
        <td>7.140</td>
        <td>false</td>
      </tr>
      <tr>
        <td><code>#7cf8b3</code></td>
        <td>{{ swatch('#7cf8b3') }}</td>
        <td><code>color(display-p3 .486 .973 .702)</code></td>
        <td>4.284</td>
        <td>true</td>
      </tr>
      <tr>
        <td><code>#f8f8f8</code></td>
        <td>{{ swatch('#f8f8f8') }}</td>
        <td><code>color(display-p3 .973 .973 .973)</code></td>
        <td>0.028</td>
        <td>true</td>
      </tr>
      <tr>
        <td><code>#e3f5fd</code></td>
        <td>{{ swatch('#e3f5fd') }}</td>
        <td><code>color(display-p3 .875 .945 .976)</code></td>
        <td>1.918</td>
        <td>true</td>
      </tr>
      <tr>
        <td><code>#e74832</code></td>
        <td>{{ swatch('#e74832') }}</td>
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

{{ figure_markup(
  image="gradient-functions.png",
  caption="The most popular gradient functions as a percent of pages.",
  description="Bar chart showing the most popular gradient functions as a percent of desktop and mobile pages. Gradient functions tend to be more popular on mobile pages. The most popular gradient function is linear-gradient, used on 73% of mobile pages. Followed by -webkit-linear-gradient on 57%, -webkit-gradient and -linear-gradient on 50%, -moz-linear-gradient on 49%, -ms-linear-gradient on 33%, radial-gradient on 15%, -webkit-radial-gradient on 9%, and repeating-linear-gradient and -moz-radial-gradient used on 3% of mobile pages.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRpe_HsNGpekn6YZV9k6QGmcZPxalqnDrL7DrDY-7X65RZEf_-aGfWuEvhk-yWV83ctIceE1bppCLpj/pubchart?oid=1552177796&format=interactive",
  sheets_gid="397884589",
  sql_file="gradient_functions.sql"
) }}

{{ figure_markup(
  image="gradient-functions-unprefixed.png",
  caption="The most popular gradient functions as a percent of pages, omitting vendor prefixes.",
  description="Bar chart showing the most popular gradient functions as a percent of desktop and mobile pages, omitting vendor prefixes. Desktop adoption is slightly behind mobile. Variations of linear-gradient are used on 72.57% of mobile pages, radial-gradient on 15.13%, repeating-linear-gradient on 2.99%, repeating-radial-gradient on 0.07%, conic-gradient on 0.01%, and repeating-conic-gradient on approximately 0.00% of mobile pages.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRpe_HsNGpekn6YZV9k6QGmcZPxalqnDrL7DrDY-7X65RZEf_-aGfWuEvhk-yWV83ctIceE1bppCLpj/pubchart?oid=1676879657&format=interactive",
  sheets_gid="397884589",
  sql_file="gradient_functions.sql"
) }}

{{ figure_markup(
  image="gradient-most-stops.png",
  caption="The gradient with the most color stops, 646.",
  description="A screenshot of the gradient with the most color stops, which is a series of intricate multicolor stripes of varying hues.",
  alt="A screenshot of the gradient with the most color stops, which is a series of intricate multicolor stripes of varying hues.",
  width=600,
  height=100
) }}

## Layout

### Flexbox and Grid adoption

{{ figure_markup(
  image="flexbox-grid-mobile.png",
  caption="Adoption of flexbox and grid by year as a percent of mobile pages.",
  description="Bar chart showing the adoption of flexbox and grid by year as a percent of mobile pages. Flexbox adoption grew from 2019 to 2020 from 41% to 63% of mobile pages. Grid adoption grew from 2% to 4% over the same time period.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRpe_HsNGpekn6YZV9k6QGmcZPxalqnDrL7DrDY-7X65RZEf_-aGfWuEvhk-yWV83ctIceE1bppCLpj/pubchart?oid=1879364309&format=interactive",
  sheets_gid="1330536609",
  sql_file="flexbox_grid.sql"
) }}

{{ figure_markup(
  image="flexbox-grid-desktop.png",
  caption="Adoption of flexbox and grid by year as a percent of dekstop pages.",
  description="Bar chart showing the adoption of flexbox and grid by year as a percent of desktop pages. Flexbox adoption grew from 2019 to 2020 from 41% to 65% of mobile pages. Grid adoption grew from 2% to 5% over the same time period.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRpe_HsNGpekn6YZV9k6QGmcZPxalqnDrL7DrDY-7X65RZEf_-aGfWuEvhk-yWV83ctIceE1bppCLpj/pubchart?oid=1140202160&format=interactive",
  sheets_gid="1330536609",
  sql_file="flexbox_grid.sql"
) }}

{{ figure_markup(
  image="layout-methods.png",
  caption="Adoption of layout methods as a percent of pages.",
  description="Bar chart showing the adoption of layout methods as a percent of desktop and mobile pages. Desktop and mobile results are similar unless otherwise noted. The top four layout methods are block, absolute, floats, and inline-block at 92%, 92%, 91%, and 90% adoption respectively. Following those, inline, fixed, and css tables have 81%, 80%, and 80% adoption respectively. Flex has 68% adoption, followed by box at 46% and distinctly larger than desktop adoption at 38%, inline-flex at 33%, grid at 30%, list-item at 26%, inline-table at 26%, inline-box at 20%, and sticky at 13% of mobile pages.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRpe_HsNGpekn6YZV9k6QGmcZPxalqnDrL7DrDY-7X65RZEf_-aGfWuEvhk-yWV83ctIceE1bppCLpj/pubchart?oid=2013998073&format=interactive",
  width="600",
  height="588",
  sheets_gid="1330536609",
  sql_file="layout_properties.sql"
) }}

### Usage of different Grid layout techniques

### Multiple-column layout

### Box sizing

{{ figure_markup(
  image="box-sizing.png",
  caption="Distribution of the number of `border-box` declarations per page.",
  description="Bar chart showing the distribution of the number of box-sizing declarations per page for desktop and mobile. The mobile distribution leads desktop by 0 to 11 declarations per page, growing in the higher percentiles. The mobile distribution's 10, 25, 50, 75, and 90th percentiles are: 0, 4, 17, 46, and 96 border-box declarations per page.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRpe_HsNGpekn6YZV9k6QGmcZPxalqnDrL7DrDY-7X65RZEf_-aGfWuEvhk-yWV83ctIceE1bppCLpj/pubchart?oid=1626960751&format=interactive",
  sheets_gid="1982524793",
  sql_file="box_sizing.sql"
) }}

## Transitions and animations

{{ figure_markup(
  image="transition-properties.png",
  caption="Adoption of transition properties as a percent of pages.",
  description="Bar chart showing the adoption of the most popular transition properties. Desktop and mobile pages are very similar except filter doesn't appear to be used significantly at all on desktop. The most popular transition property on mobile pages is all, used on 41% of pages, followed by opacity at 37%, transform at 26%, color at 17%, none at 15%, height at 13%, background-color at 12%, background at 10%, filter at 7%, and the remaining properties used on 6% of mobile pages: width, left, top, -webkit-transform, box-shadow, and border-color.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRpe_HsNGpekn6YZV9k6QGmcZPxalqnDrL7DrDY-7X65RZEf_-aGfWuEvhk-yWV83ctIceE1bppCLpj/pubchart?oid=1677028861&format=interactive",
  sheets_gid="134272305",
  sql_file="transition_properties.sql"
) }}

{{ figure_markup(
  image="transition-durations.png",
  caption="Distribution of transition durations.",
  description="Bar chart showing the distribution of transition durations in milliseconds for desktop and mobile pages. Desktop and mobile are equivalent at the 10, 25, and 90th percentiles with 100, 150, and 500ms durations respectively. However at the median and 75th percentiles, desktop has higher durations by 50ms: 300 and 400ms respectively.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRpe_HsNGpekn6YZV9k6QGmcZPxalqnDrL7DrDY-7X65RZEf_-aGfWuEvhk-yWV83ctIceE1bppCLpj/pubchart?oid=1587838983&format=interactive",
  sheets_gid="286912288",
  sql_file="transition_durations.sql"
) }}

{{ figure_markup(
  image="transition-timing-functions.png",
  caption="Relative popularity of timing functions as a percent of occurrences on mobile pages.",
  description="Pie chart showing the relative popularity of timing functions as a percent of occurrences on mobile pages. The most popular timing function is ease at 31% of occurrences, followed by linear at 19%, ease-in-out at 19%, cubic-bezier at 13%, ease-out at 9%, steps at 5%, and ease-in at 4%.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRpe_HsNGpekn6YZV9k6QGmcZPxalqnDrL7DrDY-7X65RZEf_-aGfWuEvhk-yWV83ctIceE1bppCLpj/pubchart?oid=63879013&format=interactive",
  sheets_gid="1514240349",
  sql_file="transition_timing_functions.sql"
) }}

## Visual effects

### Blend modes

### Filters

### Masks

{{ figure_markup(
  image="mask-properties.png",
  caption="Relative popularity of animation name categories as a percent of occurrences.",
  description="Relative popularity of animation name categories as a percent of occurrences. -webkit-mask-image is used on 22% of mobile pages, up from 19% on desktop. The following properties are mask-size and mask-image at 19%, mask-repeat, mask-postion, mask-mode, and -webkit-mask-size at 18%, -webkit-mask-repeat and -webkit-mask-position at 16%, and -webkit-mask and mask properties at 2% of mobile pages.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRpe_HsNGpekn6YZV9k6QGmcZPxalqnDrL7DrDY-7X65RZEf_-aGfWuEvhk-yWV83ctIceE1bppCLpj/pubchart?oid=615866471&format=interactive",
  width="600",
  height="575",
  sheets_gid="1513860089",
  sql_file="all_properties.sql"
) }}

### Clipping paths

## Responsive design

### Which media features are people using?

### Common breakpoints

{{ figure_markup(
  image="breakpoints.png",
  caption="The most popular breakpoints by `min-width` and `max-width` as a percent of mobile pages.",
  description="The most popular breakpoints by `min-width` and `max-width` as a percent of mobile pages. 480px is used as a min-width on 21% of mobile pages and as a max-width on 35%. 600px on 27% and 37% for min and max widths respectively, 767px on 8% and 50%, 768px on 54% and 35%, 800px on 8% and 24%, 991px on 3% and 30%, 992px on 37% and 11%, 1024px on 13% and 23%, 1199px on just 31% as a max-width, and 1200px on 40% and 19%.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRpe_HsNGpekn6YZV9k6QGmcZPxalqnDrL7DrDY-7X65RZEf_-aGfWuEvhk-yWV83ctIceE1bppCLpj/pubchart?oid=502128948&format=interactive",
  sheets_gid="1070028321",
  sql_file="media_query_values.sql"
) }}

{{ figure_markup(
  image="media-query-properties.png",
  caption="The most popular properties used in media queries as a percent of pages.",
  description="Bar chart of the most popular properties used in media queries as a percent of pages. Desktop and mobile are very similar. The percent of mobile pages ranges from 79% to 71% for display, width, margin-left, padding, font-size, height, margin, margin-right, margin-top, and position, in that order.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRpe_HsNGpekn6YZV9k6QGmcZPxalqnDrL7DrDY-7X65RZEf_-aGfWuEvhk-yWV83ctIceE1bppCLpj/pubchart?oid=1199544976&format=interactive",
  sheets_gid="190367365",
  sql_file="media_query_properties.sql"
) }}

### Properties used inside media queries

## Custom properties

### Naming

{{ figure_markup(
  image="custom-property-names.png",
  caption="Relative popularity of custom property names per software entity as a perecent of occurrences on mobile pages.",
  description="Pie chart of the relative popularity of custom property names per software entity responsible for creating those properties, as a percent of occurrences on mobile pages. 35% of occurrences of custom property names on mobile pages can be traced back to Avada, 31% to Bootstrap, 16% to Elementor, 13% to WordPress, and 3% to an old version of Multirange.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRpe_HsNGpekn6YZV9k6QGmcZPxalqnDrL7DrDY-7X65RZEf_-aGfWuEvhk-yWV83ctIceE1bppCLpj/pubchart?oid=1627287194&format=interactive",
  sheets_gid="1043074687",
  sql_file="custom_property_names.sql"
) }}

### Usage by type

{{ figure_markup(
  image="custom-property-properties.png",
  caption="The most popular property names used with custom properties as a percent of pages.",
  description="Bar chart of the most popular property names used with custom properties, as a percent of pages. Mobile adoption is much higher for each property than their desktop counterparts. Custom properties are used on background-color and color on 19% and 15% of mobile pages respectively. The remaining properties use custom properties from 9% to 6% in descending order: border, background, border-top, border-bottom, background-image, box-shadow, height, width, border-left, min-height, margin-top, border-right, and border-left-color. Desktop adoption is about 4 percentage points smaller.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRpe_HsNGpekn6YZV9k6QGmcZPxalqnDrL7DrDY-7X65RZEf_-aGfWuEvhk-yWV83ctIceE1bppCLpj/pubchart?oid=16420165&format=interactive",
  sheets_gid="556945658",
  sql_file="custom_property_properties.sql"
) }}

{{ figure_markup(
  image="custom-property-functions.png",
  caption="The most popular function names used with custom properties as a percent of pages.",
  description="Bar chart of the most popular function names used with custom properties, as a percent of pages. Mobile adoption is much higher for the first six functions: calc (7%), linear-gradient, rgba (4%), radial-gradient, hsla, and drop-shadow. The following functions have 1% adoption on desktop and mobile pages: -o-linear-gradient, translate, and -webkit-linear-gradient. And finally these functions have approximately 0% adoption on desktop and mobile pages: scale, -webkit-gradient, max, to, from, and rotate.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRpe_HsNGpekn6YZV9k6QGmcZPxalqnDrL7DrDY-7X65RZEf_-aGfWuEvhk-yWV83ctIceE1bppCLpj/pubchart?oid=1986770560&format=interactive",
  width="600",
  height="525",
  sheets_gid="2076074923",
  sql_file="custom_property_functions.sql"
) }}

### Complexity

{{ figure_markup(
  image="custom-property-depth.png",
  caption="Distribution of depths of custom properties as a percent of occurrences.",
  description="Bar chart of the distribution of depths of custom properties as a percent of occurrences. Custom properties on desktop and mobile page have a depth of 0 for 67% and 60% of occurrences, respectively. For a depth of 1 it is 31% and 38%. At a depth of 2, just 2% each. Approximately 0% of occurrences have a depth of 3 or more.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRpe_HsNGpekn6YZV9k6QGmcZPxalqnDrL7DrDY-7X65RZEf_-aGfWuEvhk-yWV83ctIceE1bppCLpj/pubchart?oid=262191540&format=interactive",
  sheets_gid="1368222498",
  sql_file="custom_property_depth.sql"
) }}

## CSS and JS

### Houdini

### CSS-in-JS

{{ figure_markup(
  image="css-in-js.png",
  caption="Relative popularity of CSS-in-JS libraries as a percent of occurrences on mobile pages.",
  description="Pie chart of the relative popularity of CSS-in-JS libraries as a percent of occurences on mobile pages. Styled Components makes up 42% of occurrences on mobile pages, followed by Emotion at 30%, Aphrodite at 9%, React JSS at 8%, Glamor at 7%, Styled Jsx at 2%, and the rest having less than 1% of occurences: Radium, React Native for Web, Goober, Merge Styles, Styletron, and Fela.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRpe_HsNGpekn6YZV9k6QGmcZPxalqnDrL7DrDY-7X65RZEf_-aGfWuEvhk-yWV83ctIceE1bppCLpj/pubchart?oid=969014374&format=interactive",
  sheets_gid="1368222498",
  sql_file="css_in_js.sql"
) }}

## Internationalization

### Direction

### Logical vs physical properties

## Browser support

### Vendor prefixes

{{ figure_markup(
  image="vendor-prefix-features.png",
  caption="The most popular vendor-prefixed features by type as a percent of pages.",
  description="Bar chart of the most popular vendor-prefixed features by type as a percent of pages. Desktop and mobile are very similar. 91% of mobile pages use vendor-prefixed properties, 77% use keywords and pseudo-elements, 65% use functions, 61% use pseudo-classes, and 52% use media.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRpe_HsNGpekn6YZV9k6QGmcZPxalqnDrL7DrDY-7X65RZEf_-aGfWuEvhk-yWV83ctIceE1bppCLpj/pubchart?oid=1057411197&format=interactive",
  sheets_gid="1944012653",
  sql_file="vendor_prefix_summary.sql"
) }}

{{ figure_markup(
  caption="Percent of mobile pages using any vendor prefixed feature.",
  content="91.05%",
  classes="big-number",
  sheets_gid="1944012653",
  sql_file="vendor_prefix_summary.sql"
) }}

{{ figure_markup(
  image="vendor-prefix-properties.png",
  caption="Relative popularity of properties that are most used with vendor prefixes, as a percent of occurrences.",
  description="Bar chart of the relative popularity of properties that are most used with vendor prefixes, as a percent of occurrences. Desktop and mobile have similar results. The transform property makes up 19% of vendor prefix usage, followed by 12% transition, 9% border-radius, 8% box-shadow, 5% user-select and box-sizing, 4% animation, 3% filter, 2% each of font-smoothing, backface-visibility, appearance, and flex, and 1% usage for the remaining properties: transform-origin, osx-font-smoothing, animation-name, background-size, transition-property, and tap-highlight-color.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRpe_HsNGpekn6YZV9k6QGmcZPxalqnDrL7DrDY-7X65RZEf_-aGfWuEvhk-yWV83ctIceE1bppCLpj/pubchart?oid=859599479&format=interactive",
  sheets_gid="67014375",
  sql_file="vendor_prefix_properties.sql"
) }}

{{ figure_markup(
  image="top-vendor-prefixes.png",
  caption="Relative popularity of vendor prefixes, as a percent of occurrences.",
  description="Bar chart of the relative popularity of vendor prefixes, as a percent of occurrences. -webkit makes up 49% of vendor prefix usage on mobile pages, -moz 23%, -ms 19%, -o 8%, -khtml 1%, and 0% for -pie, -js, and -ie. Desktop is similar.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRpe_HsNGpekn6YZV9k6QGmcZPxalqnDrL7DrDY-7X65RZEf_-aGfWuEvhk-yWV83ctIceE1bppCLpj/pubchart?oid=702800205&format=interactive",
  sheets_gid="67014375",
  sql_file="vendor_prefix_properties.sql"
) }}

{{ figure_markup(
  image="vendor-prefix-pseudo-classes.png",
  caption="The most popular vendor-prefixed pseudo-classes as a percent of pages.",
  description="Bar chart of the most popular vendor-prefixed pseudo-classes as a percent of pages. :ms-input-placeholder is used on 10% of mobile pages, :-moz-placeholder 8%, :-mox-focusring 2%, and 1% or less for the following: :-webkit-full-screen, :-moz-full-screen, :-moz-any-link, :-webkit-autofill, :-o-prefocus, :-ms-fullscreen, :-ms-input-placeholde [sic], :-ms-lang, :-moz-ui-invalid, :-webkit-input-placeholder, :-moz-input-placeholder, and :-webkit-any-link.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRpe_HsNGpekn6YZV9k6QGmcZPxalqnDrL7DrDY-7X65RZEf_-aGfWuEvhk-yWV83ctIceE1bppCLpj/pubchart?oid=1884876858&format=interactive",
  sheets_gid="67014375",
  width="600",
  height="650",
  sql_file="vendor_prefix_pseudo_classes.sql"
) }}

{{ figure_markup(
  image="vendor-prefix-pseudo-elements.png",
  caption="Relative popularity of vendor-prefixed pseudo-elements by purpose as a percent of occurrences.",
  description="Bar chart of the relative popularity of vendor-prefixed pseudo-elements by their purpose as a percent of occurrences. placeholder is used in 29% of prefixed occurrences, focus ring 21%, scrollbar 11%, search input 10%, media controls 8%, spinner 7%, other, selection, slider, clear button all at 3%, progress bar 2%, file upload 1%, and the remainder all at approximately 0% relative popularity on mobile pages: date picker, validation, meter, details marker, and resizer.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRpe_HsNGpekn6YZV9k6QGmcZPxalqnDrL7DrDY-7X65RZEf_-aGfWuEvhk-yWV83ctIceE1bppCLpj/pubchart?oid=2013685965&format=interactive",
  sheets_gid="1466863581",
  width="600",
  height="566",
  sql_file="vendor_prefix_pseudo_elements.sql"
) }}

{{ figure_markup(
  image="top-pseudo-element-prefixes.png",
  caption="Relative popularity of pseudo-element vendor prefixes as a percent of occurrences on mobile pages.",
  description="Pie chart of the relative popularity of pseudo-element vendor prefixes as a percent of occurrences on mobile pages. -webkit makes up 47% of pseudo-element vendor prefix usage, followed by, 26% -moz, 15% -ms, 7% -o, and 6% other.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRpe_HsNGpekn6YZV9k6QGmcZPxalqnDrL7DrDY-7X65RZEf_-aGfWuEvhk-yWV83ctIceE1bppCLpj/pubchart?oid=744523431&format=interactive",
  sheets_gid="1466863581",
  sql_file="vendor_prefix_pseudo_elements.sql"
) }}

{{ figure_markup(
  caption="Percent of occurrences of vendor-prefixed functions on mobile pages that specify gradients.",
  content="98.22%",
  classes="big-number",
  sheets_gid="1586213539",
  sql_file="vendor_prefix_functions.sql"
) }}

{{ figure_markup(
  image="vendor-prefixed-media.png",
  caption="Relative popularity of vendor-prefixed media features as a percent of occurrences on mobile pages.",
  description="Pie chart of the relative popularity of vendor-prefixed media features as a percent of occurrences on mobile pages. min-device-pixel-ratio and high-contrast each make up 47% of occurrences, transform-3d at 5%, and the remaining features less than 1% are device-pixel-ratio, max-device-pixel-ratio, and other features",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRpe_HsNGpekn6YZV9k6QGmcZPxalqnDrL7DrDY-7X65RZEf_-aGfWuEvhk-yWV83ctIceE1bppCLpj/pubchart?oid=1940027848&format=interactive",
  sheets_gid="1192245087",
  sql_file="vendor_prefix_media.sql"
) }}

### Feature queries

{{ figure_markup(
  image="supports-criteria.png",
  caption="Relative popularity of `@supports` features queried as a percent of occurrences.",
  description="Bar chart of the relative popularity of @supports features queried as a percent of occurrences. The most popular feature queried is sticky at 49% of occurrences on mobile pages, followed by ime-align at 24%, mask-image at 12%, overflow-scrolling at 5%, grid at 2%, custom properties, transform-style, max(), and object-fit all at 1%, and appearance at approximately 0%.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRpe_HsNGpekn6YZV9k6QGmcZPxalqnDrL7DrDY-7X65RZEf_-aGfWuEvhk-yWV83ctIceE1bppCLpj/pubchart?oid=1901533222&format=interactive",
  sheets_gid="1155233487",
  sql_file="supports_criteria.sql"
) }}

## Meta

### Declaration repetition

<figure>
  <table>
    <thead>
      <tr>
        <th>Percentile</th>
        <th>Unique / Total</th>
      </tr>
    </thead>
    <tbody>
      <tr>
        <td>10</td>
        <td class="numeric">30.97%</td>
      </tr>
      <tr>
        <td>50</td>
        <td class="numeric">45.43%</td>
      </tr>
      <tr>
        <td>90</td>
        <td class="numeric">63.67%</td>
      </tr>
    </tbody>
  </table>

  <figcaption>
    {{ figure_link(
      caption="Distribution of repetition ratios on mobile pages.",
      sheets_gid="2124098640",
      sql_file="repetition.sql"
    ) }}
  </figcaption>
</figure>

### Shorthands and longhands

#### Shorthands before longhands

{{ figure_markup(
  image="most-popular-longhand-after-shorthand.png",
  caption="Most popular longhand properties after shorthands.",
  description="Bar chart showing `background-size` at 15% for desktop and 41% for mobile, `background-image` at 8% and 6% respectively, `margin-bottom` at 6% and 4%, `margin-top` at 6% and 4%, `border-bottom-color` at 5% and 3%, `font-size` at 4% and 3%, `border-top-color` at 4% and 3%, `background-color` at 4% and 2%, `padding-left` at 3% and 2%, and finally `margin-left` at 3% and 2%.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRpe_HsNGpekn6YZV9k6QGmcZPxalqnDrL7DrDY-7X65RZEf_-aGfWuEvhk-yWV83ctIceE1bppCLpj/pubchart?oid=176504610&format=interactive",
  sheets_gid="17890636",
  sql_file="meta_shorthand_first_properties.sql",
  width="600",
  height="429"
) }}

{{ figure_markup(
  image="background-shorthand-versus-longhand.png",
  caption="TODO.",
  description="Bar chart showing `background` is 91% on desktop and 92% on mobile, `background-color` is 91% and 92% respectively, `background-image` is 85% and 87%, `background-position` is 84% and 85%, `background-repeat` is 82% and 84%, `background-size` is 77% and 79%, `background-clip` is 48% and 53%, `background-attachment` is 37% and 38%, `background-origin` is 5% on desktop and 12% on mobile.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRpe_HsNGpekn6YZV9k6QGmcZPxalqnDrL7DrDY-7X65RZEf_-aGfWuEvhk-yWV83ctIceE1bppCLpj/pubchart?oid=2014923335&format=interactive",
  sheets_gid="1513860089",
  sql_file="all_properties.sql",
  width="600",
  height="429"
) }}

#### font

#### background

#### Margins and paddings

{{ figure_markup(
  image="margin-padding-shorthand-vs-longhand.png",
  caption="Usage of margin/padding shorthands vs longhands.",
  description="Bar chart showing `padding` is 93% on desktop, 94% on mobile, `margin` is 93% and 93% respectively, `margin-left` is 91% and 92%, `margin-top` is 90% and 91%, `margin-right` is 90% and 91%, `margin-bottom`si 90% and 91%, `padding-left` is 90% and 90%, `padding-top` is 88% and 89%, `padding-bottom` is 88% and 89%, and `padding-right` is 87% and 88%.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRpe_HsNGpekn6YZV9k6QGmcZPxalqnDrL7DrDY-7X65RZEf_-aGfWuEvhk-yWV83ctIceE1bppCLpj/pubchart?oid=804317202&format=interactive",
  sheets_gid="1513860089",
  sql_file="all_properties.sql"
) }}

#### Flex

{{ figure_markup(
  image="flex-shorthand-vs-longhand.png",
  caption="Usage of flex shorthands vs longhands.",
  description="Bar chart showing `flex-direction` is 55% on desktop and 60% on mobile, `flex-wrap` is 55% and 58% respectively,`flex` is 52% and 56%, `flex-grow` is 44% and 52%,`flex-basis` is 40% and 44%,`flex-shrink` is 28% and 37%, `flex-flow` is 27% and 30%.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRpe_HsNGpekn6YZV9k6QGmcZPxalqnDrL7DrDY-7X65RZEf_-aGfWuEvhk-yWV83ctIceE1bppCLpj/pubchart?oid=930720666&format=interactive",
  sheets_gid="1513860089",
  sql_file="all_properties.sql"
) }}

#### Grid

{{ figure_markup(
  image="usage-of-grid-properties.png",
  caption="Usage of grid, grid-* properties.",
  description="Bar chart showing `grid-template-columns` is 27% on desktop and 26% on mobile, `grid-template-rows` is 24% and 24% respectively, `grid-column` is 20% and 20%, `grid-row` is 20% and 19%, `grid-area` is 6% and 6%, `grid-template-areas` is 6% and 6%, `grid-gap` is 4% and 5%, `grid-column-gap` is 4% and 3%, `grid-row-gap` is 3% and 3%, `grid-column-end` is 3% and 2%, `grid-column-start` is 3% and 2%, `grid-row-start` is 3% and 2%, `grid-row-end` is 2% and 2%, `grid-auto-columns` is 2% and 2%, `grid-auto-rows` is 1% and 1%, `grid-auto-flow` is 1% and 1%, `grid-template` is 0% and 0%, `grid` is 0% and 0%, `grid-column-span` is 0% and 0%, `grid-columns` is 0% and 0%, and `grid-rows` is 0% and 0%.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRpe_HsNGpekn6YZV9k6QGmcZPxalqnDrL7DrDY-7X65RZEf_-aGfWuEvhk-yWV83ctIceE1bppCLpj/pubchart?oid=290183398&format=interactive",
  sheets_gid="1513860089",
  sql_file="all_properties.sql",
  width="600",
  height="575"
) }}

### CSS mistakes

#### Syntax errors

#### Nonexistent properties

{{ figure_markup(
  image="most-popupular-unknown-properties.png",
  caption="Most popular unknown properties.",
  description="Bar chart showing `webkit-transition` is 15% on desktop and 14% on mobile, `font-smoothing` is 13% and 12% respectively, `user-drag` is 12% on mobile, `white-wpace` is 10% on mobile, `tap-highlight-color` is 10% and 10%, `webkit-box-shadow` is 4% and 4%, `ms-transform` is 2% and 2%, `-transition` is 1% and 1%, `font-rendering` is 0% and 0%, `webkit-border-radius` is 2% on desktop, and `moz-border-radius` is 2% on desktop.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRpe_HsNGpekn6YZV9k6QGmcZPxalqnDrL7DrDY-7X65RZEf_-aGfWuEvhk-yWV83ctIceE1bppCLpj/pubchart?oid=1166982997&format=interactive",
  sheets_gid="84286607",
  sql_file="meta_unknown_properties.sql",
  width="600",
  height="401"
) }}

#### Longhands before shorthands

{{ figure_markup(
  image="most-popupular-shorthands-after-longhands.png",
  caption="Most popular shorthands after longhands.",
  description="Bar chart showing `background` is 56.46% of desktop and 55.17% of mobile, `margin` is 12.51% and 12.18% respectively, `font` is 10.15% and 10.31%, `padding` is 8.36% and 7.87%, `border-radius` is 1.08% and 3.14%, `animation` is 3.18% and 3.05%, `list-style` is 2.09% and 2.00%, and `transition` is 1.09% and 0.98%.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRpe_HsNGpekn6YZV9k6QGmcZPxalqnDrL7DrDY-7X65RZEf_-aGfWuEvhk-yWV83ctIceE1bppCLpj/pubchart?oid=1389278729&format=interactive",
  sheets_gid="1143644053",
  sql_file="meta_longhand_first_properties.sql"
) }}

## Sass

{{ figure_markup(
  image="most-popupular-sass-function-calls.png",
  caption="Most popular Sass function calls.",
  description="Bar chart showing `(other)` is used on 23% on desktop and 23% on mobile, `darken` is 17% and 18% respectively, `if` is 14% and 14%, `map-keys` is 8% and 9%, `percentage` is 8% and 8%, `map-get` is 8% and 7%, `lighten` is 5% and 6%, `nth` is 5% and 5%, `mix` is 4% and 4%, `length` is 3% and 3%, `type-of` is 2% and 2%, and `(alpha adjustment)` 2% on desktop and 2% on mobile.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRpe_HsNGpekn6YZV9k6QGmcZPxalqnDrL7DrDY-7X65RZEf_-aGfWuEvhk-yWV83ctIceE1bppCLpj/pubchart?oid=774248494&format=interactive",
  sheets_gid="170555219",
  sql_file="sass_function_calls.sql"
) }}

{{ figure_markup(
  image="usage-of-control-flow-statements-scss.png",
  caption="Usage of control flow statements in SCSS.",
  description="Bar chart showing `@if` is used on 63% of desktop and 63% of mobile, `@for` is 55% and 55% respectively, `@each` is 54% and 55%, and `@while` is 2% and 2%.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRpe_HsNGpekn6YZV9k6QGmcZPxalqnDrL7DrDY-7X65RZEf_-aGfWuEvhk-yWV83ctIceE1bppCLpj/pubchart?oid=157473209&format=interactive",
  sheets_gid="498478750",
  sql_file="sass_control_flow_statements.sql"
) }}

{{ figure_markup(
  image="usage-of-explicit-nesting-in-scss.png",
  caption="usage-of-explicit-nesting-in-scss.",
  description="Bar chart showing `Total` is used by 85% on desktop and 85% on mobile, `&:pseudo-class` is 83% and 83% respectively, `&.class` is 80% and 80%, `&::pseudo-element` is 66% and 66%, `& (by itself)` is 62% and 62%, `&[attr]` is 57% and 57%, `& >`	24% and 23%, `& +`	21% and 20%, `& descendant` is 16% and 15%, and `&#id` is 6% on desktop and 6% on mobile.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRpe_HsNGpekn6YZV9k6QGmcZPxalqnDrL7DrDY-7X65RZEf_-aGfWuEvhk-yWV83ctIceE1bppCLpj/pubchart?oid=370242263&format=interactive",
  sheets_gid="1872903377",
  sql_file="sass_nesting.sql"
) }}

## Conclusion
