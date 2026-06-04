# 2025 CSS queries

<!--
  This directory contains all of the 2025 CSS chapter queries.

  Each query should have a corresponding `metric_name.sql` file.
  Note that readers are linked to this directory, so try to make the SQL file names descriptive for easy browsing.

  Analysts: if helpful, you can use this README to give additional info about the queries.
-->

## Resources

- [📄 Planning doc][~google-doc]
- [📊 Results sheet][~google-sheets]
- [📝 Markdown file][~chapter-markdown]

[~google-doc]: https://docs.google.com/document/d/1FtntjUvqNT_66XtKQamZDPy0gI_kLZhkBaK7JJwE2ww
[~google-sheets]: https://docs.google.com/spreadsheets/d/1jGINqaVnYrlu7ob4jvxtAafyBH8PCV0BX-UbTCgDsiM/edit
[~chapter-markdown]: https://github.com/HTTPArchive/almanac.httparchive.org/tree/main/src/content/en/2025/css.md

## Queries

Notes:
* The metrics descriptions that mention "per year", will be reported for all the years from 2019 to 2025, unless explicitly mentioned otherwise
* Percentile metrics will be reported for the 10, 25, 50, 75, and 90th percentiles, unless explicitly mentioned otherwise

### CSS composition

- Stylesheets
  - [stylesheet-metrics.sql][stylesheet-metrics.sql]
  - [stylesheet-percentile-metrics.sql][stylesheet-percentile-metrics.sql]
- Lines of code
  - [ ] percentiles of lines of code per stylesheet, per year
  - [ ] percentiles of lines of code per page, per year
  - [ ] percentiles for atrules, rules, selectors and declarations per page, per year
- Embedded content
  - [ ] percentiles of embedded content size, per year
- Comments
  - [ ] percentiles of comments per page, per year
