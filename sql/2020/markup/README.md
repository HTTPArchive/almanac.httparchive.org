# Guide

## file naming
file names start with the table being queried. Next is the custom metric if appropriate. Then "_by_" followed by how the query is grouped. Finally anything more specific needed.

Queries contain one or more metrics that match the queries grouping structure.

## general

percents should be 0-1
always segment by device (client)
total for the denominator, freq for the numerator, and pct for the fraction

percentiles (10, 25, 50, 75 and 90th) The y-axis min should almost always be 0 and usually the max that gets automatically rendered is good enough. So no max min required?

Some common query patterns:

## _by_device

Example: pages_markup_by_device.sql

### AS_PERCENT function

This makes it simpler to create percent based fields. It may be added as a shared function for all.

```
# helper to create percent fields
CREATE TEMP FUNCTION AS_PERCENT (freq FLOAT64, total FLOAT64) RETURNS FLOAT64 AS (
  ROUND(SAFE_DIVIDE(freq, total), 4)
);
```

In use:

```
 AS_PERCENT(COUNTIF(element_count_info.contains_custom_element), COUNT(0)) AS pct_contains_custom_element,
```

### custom metrics functions

For speed the json string for the custom metric (not payload) should be passed in and the function can return multiple values via a STRUCT. This minimises json parsing in the JS which seems to be slow.

```
CREATE TEMPORARY FUNCTION get_element_count_info(element_count_string STRING)
RETURNS STRUCT<
  count INT64,
  contains_custom_element BOOL,
  contains_obsolete_element BOOL,
  contains_details_element BOOL,
  contains_summary_element BOOL
> LANGUAGE js AS '''
var result = {};
try {
    if (!element_count_string) return result;

    var element_count = JSON.parse(element_count_string);

    if (Array.isArray(element_count) || typeof element_count != 'object') return result;

    // fill result with all the values

    result.count = Object.values(element_count).reduce((total, freq) => total + (parseInt(freq, 10) || 0), 0);

    //...

} catch (e) {}
return result;
''';
```

Make sure you do null/undefined checks in your js code when digging into an object. We don't want a simple error causing the loss of data. No issue in setting a value to null or undefined as it gets converted into a NULL.

```
    if (almanac.html_node) {
      result.html_node_lang = almanac.html_node.lang;
    }
```

To get the info first extracts the custom metric from the payload using the fast JSON_EXTRACT_SCALAR. Then the returned STRUCT values can be accessed with dot notation.

```
SELECT
  client,
  COUNT(0) AS total,

  # % of pages with custom elements ("slang") related to M242
  COUNTIF(element_count_info.contains_custom_element) AS freq_contains_custom_element,
  AS_PERCENT(COUNTIF(element_count_info.contains_custom_element), COUNT(0)) AS pct_contains_custom_element,

  #...

  FROM
    (
      SELECT
        _TABLE_SUFFIX AS client,
        get_element_count_info(JSON_EXTRACT_SCALAR(payload, '$._element_count')) AS element_count_info # LIVE
      FROM
        `httparchive.sample_data.pages_*` # TEST
    )
GROUP BY
  client
```

## _by_device_and_percentile

Example: pages_markup_by_device_and_percentile.sql

This would typically use the exact same function to extract the data. The select adds in the percentiles and uses a standard field definition to extract the data

```
SELECT
  percentile,
  client,
  COUNT(DISTINCT url) AS total,

  # Elements per page
  APPROX_QUANTILES(element_count_info.count, 1000)[OFFSET(percentile * 10)] AS elements_count,

  #...

FROM (
  SELECT
    _TABLE_SUFFIX AS client,
    percentile,
    url,
    get_element_count_info(JSON_EXTRACT_SCALAR(payload, '$._element_count')) AS element_count_info
  FROM
  `httparchive.sample_data.pages_*`, # TEST
  UNNEST([10, 25, 50, 75, 90]) AS percentile
)
GROUP BY
  percentile,
  client
ORDER BY
  percentile,
  client
```

## Testing

For testing I change the start of the function and hard code some random data. e.g.

```
var result = {};
try {
    // var almanac = JSON.parse(almanac_string); // LIVE

    // TEST
    var almanac = {
      "scripts": {
        "total": Math.floor(Math.random()*10)
    };

    if (Array.isArray(almanac) || typeof almanac != 'object') return result;

    // ...
```

To speed up queries the call to the test function can also be faked:

```
        get_almanac_info('') AS almanac_info  # TEST
        #get_almanac_info(JSON_EXTRACT_SCALAR(payload, '$._almanac')) AS almanac_info # LIVE
```
