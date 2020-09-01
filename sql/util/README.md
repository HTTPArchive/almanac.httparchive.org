# Web Almanac SQL utils

This directory contains utilities for managing the Web Almanac dataset on BigQuery.

## [summary_requests.sql](./summary_requests.sql)

This query generates summary metadata about each request from its JSON-encoded HAR object. For every Web Almanac crawl (eg 2019_07_01 and 2020_08_01) this query should be run once and configured to have its results appended to the `almanac.requests` table. This table is useful for Web Almanac analysis because it combines the metadata of the request with the HAR payload, more easily enabling queries that segment requests by resource type (script, style, image) and base HTML page.

## [summary_response_bodies.sql](./summary_response_bodies.sql)

This query combines `almanac.requests` with the `response_bodies.YYYY_MM_DD` tables. For every Web Almanac crawl (eg 2019_07_01 and 2020_08_01) this query should be run once and configured to have its results appended to the `almanac.summary_response_bodies` table.

## [parsed_css.sql](./parsed_css.sql), [parsed_css_inline.sql](./parsed_css_inline.sql)

These queries take the CSS response bodies and parse them using Rework CSS to generate a queryable, JSON-formatted AST. For every Web Almanac crawl (eg 2019_07_01 and 2020_08_01) each query should be run once and configured to have its results appended to the `almanac.parsed_css` table.

## [third_parties.sql](./third_parties.sql)

This query copies the [Third Party Web](https://github.com/patrickhulce/third-party-web) category data. Coordinate with @patrickhulce to publish a new version of the table based on the latest HTTP Archive data, then append the results of this query to the `almanac.third_parties` table.