# standardSQL
# Count Microdata item types
CREATE TEMP FUNCTION getMicrodataItemTypes(rendered STRING)
RETURNS ARRAY<STRING>
LANGUAGE js AS """
  try {
    rendered = JSON.parse(rendered);
    return rendered.microdata_itemtypes.map(itemType => itemType.toLowerCase());
  } catch (e) {
    return [];
  }
""";

WITH
rendered_data AS (
  SELECT
    getMicrodataItemTypes(rendered) AS microdata_item_types,
    client
  FROM (
    SELECT
      JSON_EXTRACT(JSON_VALUE(JSON_EXTRACT(payload,
            '$._structured-data')),
        '$.structured_data.rendered') AS rendered,
      _TABLE_SUFFIX AS client
    FROM
      `httparchive.pages.2021_07_01_*`)
)

SELECT
  microdata_item_type,
  COUNT(microdata_item_type) AS count,
  SUM(COUNT(microdata_item_type)) OVER (PARTITION BY client) AS total,
  COUNT(microdata_item_type) / SUM(COUNT(microdata_item_type)) OVER (PARTITION BY client) AS pct,
  client
FROM (
  SELECT
    -- Removes the protocol and any subdomains from the URL.
    -- e.g. "https://my.example.com/pathname" becomes "example.com/pathname"
    -- This is done to normalize the URL a bit before counting.
    CONCAT(NET.REG_DOMAIN(microdata_item_type), SPLIT(microdata_item_type, NET.REG_DOMAIN(microdata_item_type))[SAFE_OFFSET(1)]) AS microdata_item_type,
    client
  FROM
    rendered_data,
    UNNEST(microdata_item_types) AS microdata_item_type
)
GROUP BY
  microdata_item_type,
  client
ORDER BY
  count DESC
