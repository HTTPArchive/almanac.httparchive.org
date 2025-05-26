# 2025 Fonts queries

## Resources

* 📄 [Planning document]
* 📊 [Results sheet]
* 📝 [Chapter content]

## Structure

The queries are split by the section where they are used:

* `design/` is about foundries and families,
* `development/` is about tools and technologies, and
* `performance/` is about hosting and serving.

Each file name starts with one of the following prefixes indicating the primary
subject of the corresponding analysis:

* `fonts_` is about font files,
* `pages_` is about HTML pages,
* `scripts_` is about JavaScript scripts, and
* `styles_` is about CSS style sheets.

The prefix is followed by the property studied given in singular, potentially
extended one or several suffixes narrowing down the scope, as in
`fonts_size_by_table.sql` and `pages_link_relation.sql`.

## Contents

Each query starts with a preamble indicating the section, question, and
normalization type:

```sql
-- Section: Performance
-- Question: What is the distribution of the file size broken down by table?
-- Normalization: Pages
```

Many queries rely on temporary functions for convenience and clarity. The
functions appear in several queries are extracted into a common file:
`common.sql`. Whenever any of the functions defined in `common.sql` is used by a
query, the query has the following line at the top:

```sql
-- INCLUDE https://github.com/HTTPArchive/almanac.httparchive.org/blob/main/sql/2025/fonts/common.sql
```

It signalizes that, prior to executing the query, `common.sql` has to be
inlined.

[Planning document]: https://docs.google.com/document/d/1ljEHbDvXComXnW5s_EXZ0nM3_JCLnYr28Xrcf0YYtP8/edit
[Results sheet]: https://docs.google.com/spreadsheets/d/1EkdvJ8e0B9Rr42evC2Ds5Ekwq6gF9oLBW0BA5cmSUT4/edit
[Chapter content]: https://github.com/HTTPArchive/almanac.httparchive.org/tree/main/src/content/en/2025/fonts.md
