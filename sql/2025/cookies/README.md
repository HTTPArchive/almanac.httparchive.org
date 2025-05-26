# 2025 Cookies queries

<!--
  This directory contains all of the 2025 cookies chapter queries.

  Each query should have a corresponding `metric_name.sql` file.
  Note that readers are linked to this directory, so try to make the SQL file names descriptive for easy browsing.

  Analysts: if helpful, you can use this README to give additional info about the queries.
-->

## Resources

- [📄 Planning doc][~google-doc]
- [📊 Results sheet][~google-sheets]
- [📝 Markdown file][~chapter-markdown]

[~google-doc]: https://docs.google.com/document/d/1JX7vklpKJa_4RImgC8bfNNa9V725FaF0HH6RJcbRnYU
[~google-sheets]: https://docs.google.com/spreadsheets/d/1ZirsnaXgbOMzBmt0X2eMMu3rVJvWCtQgE7pNG7fKcvc
[~chapter-markdown]: https://github.com/HTTPArchive/almanac.httparchive.org/tree/main/src/content/en/2025/cookies.md

## Note about SQL queries

First execute [`0_create_cookies.sql`](0_create_cookies.sql) to export the
results of the <DATE> crawl specified into the `httparchive.almanac.cookies`
table that will then be used in other SQL queries.
