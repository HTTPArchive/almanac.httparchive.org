#standardSQL
# Image loading property usage
# Note: This query only reports if an attribute was ever used on a page. It is not a per img report.

# returns all the data we need from _markup
CREATE TEMPORARY FUNCTION getLoadingPropertyMarkupInfo(markup_string STRING)
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

    if (markup.images && markup.images.img && markup.images.img.loading) {
      result.loading = getKey(markup.images.img.loading);
    }
} catch (e) {}
return result;
''';

SELECT
  client,
  loading,
  total,
  COUNT(0) AS count,
  SAFE_DIVIDE(COUNT(0), SUM(COUNT(0)) OVER (PARTITION BY client)) AS pct
FROM (
  SELECT
    _TABLE_SUFFIX AS client,
    total,
    getLoadingPropertyMarkupInfo(JSON_EXTRACT_SCALAR(payload, '$._markup')) AS loading_property_markup_info
  FROM
    `httparchive.pages.2021_07_01_*`
  JOIN (
    SELECT _TABLE_SUFFIX, COUNT(0) AS total
    FROM
      `httparchive.pages.2021_07_01_*`
    GROUP BY _TABLE_SUFFIX
  )
  USING (_TABLE_SUFFIX)
),
  UNNEST(loading_property_markup_info.loading) AS loading
GROUP BY
  total,
  loading,
  client
