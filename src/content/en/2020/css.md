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
  caption="Relative popularity of font-based units other than `px` as a percent of occurrences.",
  description="Bar chart showing the relative popularity of font-based units other than px. em is used overwhelmingly on 87.3% of instances, followed by rem at 12.2, ch at 0.4%, and ex at 0.2% of instances on mobile pages.",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vRpe_HsNGpekn6YZV9k6QGmcZPxalqnDrL7DrDY-7X65RZEf_-aGfWuEvhk-yWV83ctIceE1bppCLpj/pubchart?oid=1935151776&format=interactive",
  sheets_gid="313150061",
  sql_file="units_zero.sql"
) }}

### Calculations

### Global keywords and `all`

## Color

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
