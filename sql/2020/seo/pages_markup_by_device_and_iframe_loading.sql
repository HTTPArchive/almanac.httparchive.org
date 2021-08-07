#standardSQL
# pages markup metrics grouped by device and iframe loading attributes
# Note: this query only reports if an attribute was ever used on a page. It is not a per iframe report.

# helper to create percent fields
CREATE TEMP FUNCTION AS_PERCENT (freq FLOAT64, total FLOAT64) RETURNS FLOAT64 AS (
  ROUND(SAFE_DIVIDE(freq, total), 4)
);

# returns all the data we need from _markup
CREATE TEMPORARY FUNCTION get_markup_info(markup_string STRING)
RETURNS STRUCT<
  loading ARRAY<STRING>
> LANGUAGE js AS '''
var result = {};

//Function to retrieve only keys if value is >0
function getKey(dict){
  const arr = [],
  obj = Object.keys(dict);
  for (var x in obj){
    if(dict[obj[x]] > 0){
      arr.push(obj[x]);
    }
  }
  return arr;
}

try {
    var markup = JSON.parse(markup_string);

    if (Array.isArray(markup) || typeof markup != 'object') return result;

    if (markup.iframes && markup.iframes.loading) {
      result.loading = getKey(markup.iframes.loading);
    }
} catch (e) {}
return result;
''';

SELECT
  client,
  loading,
  total,
  COUNT(0) AS count,
  SUM(COUNT(0)) OVER (PARTITION BY client) AS device_count,
  AS_PERCENT(COUNT(0), SUM(COUNT(0)) OVER (PARTITION BY client)) AS pct
FROM (
      SELECT
        _TABLE_SUFFIX AS client,
        total,
        get_markup_info(JSON_EXTRACT_SCALAR(payload, '$._markup')) AS markup_info
      FROM
        `httparchive.pages.2020_08_01_*`
      JOIN (
        SELECT
          _TABLE_SUFFIX,
          COUNT(0) AS total
        FROM
          `httparchive.pages.2020_08_01_*`
        GROUP BY
           _TABLE_SUFFIX) # to get an accurate total of pages per device. also seems fast
      USING
        (_TABLE_SUFFIX)
    ),
UNNEST(markup_info.loading) AS loading
GROUP BY
  total, loading, client
