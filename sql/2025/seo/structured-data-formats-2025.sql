#standardSQL
# Structured data formats

# returns all the data we need from _wpt_bodies
CREATE TEMPORARY FUNCTION getStructuredDataWptBodies(wpt_bodies JSON)
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
    if (Array.isArray(wpt_bodies) || typeof wpt_bodies != 'object') return result;

    if (wpt_bodies.structured_data && wpt_bodies.structured_data.rendered && wpt_bodies.structured_data.rendered.items_by_format) {
        result.items_by_format = getKey(wpt_bodies.structured_data.rendered.items_by_format);
    }

} catch (e) {}
return result;
''';

WITH structured_data AS (
  SELECT
    client,
    root_page,
    CASE
      WHEN is_root_page = FALSE THEN 'Secondarypage'
      WHEN is_root_page = TRUE THEN 'Homepage'
      ELSE 'No Assigned Page'
    END AS is_root_page,
    page,
    getStructuredDataWptBodies(custom_metrics.wpt_bodies) AS structured_data_wpt_bodies_info,
    COUNT(DISTINCT root_page) OVER (PARTITION BY client) AS total_sites
  FROM
    `httparchive.crawl.pages`
  WHERE
    date = '2025-07-01'
)

SELECT
  client,
  is_root_page,
  format,
  COUNT(DISTINCT root_page) AS sites,
  COUNT(DISTINCT root_page) / ANY_VALUE(total_sites) AS pct
FROM
  structured_data,
  UNNEST(structured_data_wpt_bodies_info.items_by_format) AS format
GROUP BY
  client,
  is_root_page,
  format
ORDER BY
  sites DESC
