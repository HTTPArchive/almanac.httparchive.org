# Fonts

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
-- INCLUDE https://github.com/HTTPArchive/almanac.httparchive.org/blob/main/sql/{year}/fonts/common.sql
```

It signalizes that, prior to executing the query, `common.sql` has to be
inlined.

## Execution

The queries can be executed using the `execute.py` script. First, ensure that
the Application Default Credentials authorization strategy is configured, and
that the HTTP Archive project is used as the quota project:

```shell
gcloud auth application-default login
gcloud auth application-default set-quota-project httparchive
```

Second, install the Python prerequisites for the script:

```shell
pip install -r requirements.txt
```

The script can be run for all or a subset of the queries as illustrated below:

```shell
python execute.py
python execute.py design/*.sql
python execute.py development/fonts_*.sql
```

By default, it operates in a dry-run mode: it does not run the queries but
prints an estimate of the amount of data that would be processed by each query.
To disable the dry-run mode and actually run the queries, pass the
`--no-dry-run` option as follows:

```shell
python execute.py --no-dry-run
python execute.py --no-dry-run design/*.sql
python execute.py --no-dry-run development/fonts_*.sql
```

[Planning document]: https://docs.google.com/document/d/1jVc0vgmAY_lBxryItRBguXxEq77mvbaQ3UpbTweUoSI
[Results sheet]: https://docs.google.com/spreadsheets/d/1otdu4p_CCI70B4FVzw6k02frStsPMrQoFu7jUim_0Bg
[Chapter content]: https://github.com/HTTPArchive/almanac.httparchive.org/tree/main/src/content/en/2025/fonts.md
