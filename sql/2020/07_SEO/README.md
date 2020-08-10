# Guide

almanac.js queries are identified by rendered\_ and body queries by raw\_.

I've tried to merge as many queries as possible based on the data source and format of the results. This should make it a lot easier to manage as well as save on the number of queries made $$$

lighthouse.sql - all data from lighthouse
rendered\_by\_device.sql - rendered data from almanac.js grouped by device
rendered\_percentiles\_by\_device.txt - rendered data from almanac.js reported by percentiles and grouped by device
raw\_by\_device.sql - data from the raw html - very expensive query when done on the real data - does not gather much at the moment. This could become our raw/rendered comparison query.

Other scripts are ones that have a unique output so can't be merged. Typically because they group by the field they are analysing.

At the moment most are pointing to test tables. But be careful. Always double check the cost before making a query as some old ones are still pointing to live tables. We could do with a test table for httparchive.almanac.summary_response_bodies as the table I'm currently testing with is in a different format.

## helper to create percent based fields
```
CREATE TEMP FUNCTION AS_PERCENT (freq FLOAT64, total FLOAT64) RETURNS FLOAT64 AS (
  ROUND(SAFE_DIVIDE(freq, total), 4)
);
SELECT
AS_PERCENT(123, 1234567) AS pct_test,
```

## JSON helpers
```
JSON_EXTRACT = returns a string
JSON_EXTRACT_SCALAR = returns string, number, boolean
JSON_EXTRACT_ARRAY
JSON_QUERY
JSON_VALUE

SELECT ARRAY(
  SELECT CAST(integer_element as INT64)
  FROM UNNEST(
    JSON_EXTRACT_ARRAY('[1,2,3]','$')
  ) AS integer_element
) AS integer_array
```
