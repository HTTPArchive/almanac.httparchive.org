#standardSQL
# Structured data formats

# returns all the data we need from _wpt_bodies
CREATE TEMPORARY FUNCTION getStructuredDataWptBodies(wpt_bodies_string STRING)
RETURNS STRUCT<
  items_by_format ARRAY<STRING>
> LANGUAGE js AS '''
var result = {
items_by_format: []
};

//Function to retrieve only keys if value is > 0
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
    var wpt_bodies = JSON.parse(wpt_bodies_string);

    if (Array.isArray(wpt_bodies) || typeof wpt_bodies != 'object') return result;

    if (wpt_bodies.structured_data && wpt_bodies.structured_data.rendered && wpt_bodies.structured_data.rendered.items_by_format) {
        result.items_by_format = getKey(wpt_bodies.structured_data.rendered.items_by_format);
    }

} catch (e) {}
return result;
''';

SELECT
  client,
  format,
  total,
  COUNT(0) AS count,
  SAFE_DIVIDE(COUNT(0), SUM(COUNT(0)) OVER (PARTITION BY client)) AS pct

FROM (
  SELECT
    _TABLE_SUFFIX AS client,
    total,
    getStructuredDataWptBodies(JSON_EXTRACT_SCALAR(payload, '$._wpt_bodies')) AS structured_data_wpt_bodies_info
  FROM
    `httparchive.pages.2022_07_01_*` -- noqa: CV09
  JOIN (
    SELECT
      _TABLE_SUFFIX,
      COUNT(0) AS total
    FROM
      `httparchive.pages.2022_07_01_*` -- noqa: CV09
    GROUP BY
      _TABLE_SUFFIX
  )
  USING (_TABLE_SUFFIX)
), UNNEST(structured_data_wpt_bodies_info.items_by_format) AS format
GROUP BY
  total,
  format,
  client
ORDER BY
  count DESC
