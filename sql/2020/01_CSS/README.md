# CSS Queries

## Query size warning

The 2020 data in the [`parsed_css`](https://console.cloud.google.com/bigquery?p=httparchive&d=almanac&t=parsed_css&page=table) table is 9.7 TB, which is approximately $50 per query.

When prototyping queries, it's advisable to use the [`parsed_css_1k`](https://console.cloud.google.com/bigquery?p=httparchive&d=almanac&t=parsed_css_1k&page=table) table instead, which only contains 1000 rows for easier testing. Make sure to switch this back to the full table when saving the results for analysis.

## [Rework utils](../../lib/rework-utils.js)

- **Source**: https://github.com/LeaVerou/rework-utils/tree/master/src
- **Playground**: https://projects.verou.me/rework-utils/
- **Docs**: https://projects.verou.me/rework-utils/docs/

This file provides JS utility functions to be used by the queries that depend on the `parsed_css` table.

## Related resources

- [Tracking issue](https://github.com/HTTPArchive/almanac.httparchive.org/issues/898)
- [Draft doc](https://docs.google.com/document/d/1Cy9acip1ZQScoQEeds5-6l1FFFBJTJr4SheZiQxbj-Q/edit?usp=sharing)
- [Results sheet](https://docs.google.com/spreadsheets/d/1sMWXWjMujqfAREYxNbG_t1fOJKYCA6ASLwtz4pBQVTw/edit?usp=sharing)