# CSS Queries

## Query size warning

The 2021 data in the [`parsed_css`](https://console.cloud.google.com/bigquery?p=httparchive&d=almanac&t=parsed_css&page=table) table is 13 TB, which is approximately $65 per query.

When prototyping queries, it's advisable to use the [`parsed_css_1k`](https://console.cloud.google.com/bigquery?p=httparchive&d=almanac&t=parsed_css_1k&page=table) table instead, which only contains 1000 rows for easier testing. Make sure to switch this back to the full table when saving the results for analysis.

## [CSS utils](../../lib/css-utils.js)

This file provides JS utility functions to be used by the queries that depend on the `parsed_css` table.
It consists of two libraries:

### Rework Utils

Utilities to make it easier to write metrics that operate on the Rework AST

- **Source**: https://github.com/LeaVerou/rework-utils/tree/master/src
- **Playground**: https://projects.verou.me/rework-utils/
- **Docs**: https://projects.verou.me/rework-utils/docs/

### Parsel

A selector parser & specificity calculator.

- **Source**: https://github.com/LeaVerou/parsel/tree/master/
- **Playground**: https://projects.verou.me/parsel/
- **Docs**: https://projects.verou.me/parsel/#api

## Related resources

- [Tracking issue](https://github.com/HTTPArchive/almanac.httparchive.org/issues/2140)
- [Draft doc](https://docs.google.com/document/d/18OV1ngkQxdJdENkYzHOdNRtzMLo1vVv9Tg6a9pGfSSE/edit?usp=sharing)
- [Results sheet](https://docs.google.com/spreadsheets/d/12vQIA0xsC5Jr3J9Sh03AcAvgFjMAmP1xSS6Tjai9LF0/edit?usp=sharing)
