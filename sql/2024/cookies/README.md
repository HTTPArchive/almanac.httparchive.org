# 2024 Cookies queries

<!--
  This directory contains all of the 2024 cookies chapter queries.

  Each query should have a corresponding `metric_name.sql` file.
  Note that readers are linked to this directory, so try to make the SQL file names descriptive for easy browsing.

  Analysts: if helpful, you can use this README to give additional info about the queries.
-->

## Resources

- [📄 Planning doc][~google-doc]
- [📊 Results sheet][~google-sheets]
- [📝 Markdown file][~chapter-markdown]

[~google-doc]: https://docs.google.com/document/d/1o2AgdsDq_x3OvthZF7Kb50rUKMVLn7UANT9Stz7ku2I/edit#heading=h.ymg495uvm3yx
[~google-sheets]: https://docs.google.com/spreadsheets/d/1wDGnUkO0rgcU5_V6hmUrhm1pq60VU2XbeMHgYJEEaSM/edit#gid=454016814
[~chapter-markdown]: https://github.com/HTTPArchive/almanac.httparchive.org/tree/main/src/content/en/2024/cookies.md

## Note about SQL queries

First execute [`0_create_cookies.sql`](0_create_cookies.sql) to export the
results of the <DATE> crawl specified into the `httparchive.almanac.cookies`
table that will then be used in other SQL queries.
