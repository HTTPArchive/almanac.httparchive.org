# Create a temporary function to extract the loading properties from the markup
CREATE TEMPORARY FUNCTION getLoadingPropertyMarkupInfo(markup JSON)
RETURNS STRUCT<
  loading ARRAY<STRING>
> LANGUAGE js AS '''
var result = {};

// Function to retrieve only keys if value is >0
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
    if (Array.isArray(markup) || typeof markup != 'object') return result;

    if (markup.images && markup.images.img && markup.images.img.loading) {
      result.loading = getKey(markup.images.img.loading);
    }
} catch (e) {}
return result;
''';

WITH image_loading AS (
  SELECT
    client,
    root_page,
    is_root_page,
    page,
    getLoadingPropertyMarkupInfo(custom_metrics.markup) AS loading_property_markup_info
  FROM
    `httparchive.crawl.pages`
  WHERE
    date = '2025-07-01'
)

SELECT
  client,
  loading,
  COUNT(DISTINCT root_page) AS sites,
  COUNT(DISTINCT page) AS total_pages,
  COUNTIF(is_root_page = TRUE) AS count_homepage,
  COUNTIF(is_root_page = FALSE) AS count_secondarypage,
  COUNTIF(is_root_page = TRUE) / COUNT(DISTINCT page) AS homepage_pct,
  COUNTIF(is_root_page = FALSE) / COUNT(DISTINCT page) AS secondary_pct
FROM
  image_loading,
  UNNEST(loading_property_markup_info.loading) AS loading
GROUP BY
  client,
  loading
ORDER BY
  client,
  loading;
