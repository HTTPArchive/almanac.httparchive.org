# standardSQL
# microdata_item_types.sql
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
    client,
    root_page AS url,
    getMicrodataItemTypes(JSON_EXTRACT(JSON_VALUE(JSON_EXTRACT(payload, '$._structured-data')), '$.structured_data.rendered')) AS microdata_item_types
  FROM
    `httparchive.all.pages`
  WHERE
    date = '2024-06-01'
),

page_totals AS (
  SELECT
    client,
    COUNT(DISTINCT root_page) AS total_pages
  FROM
    `httparchive.all.pages`
  WHERE
    date = '2024-06-01'
  GROUP BY
    client
)

SELECT
  client,
  microdata_item_type,
  COUNT(microdata_item_type) AS freq_microdata,
  SUM(COUNT(microdata_item_type)) OVER (PARTITION BY client) AS total_microdata,
  COUNT(microdata_item_type) / SUM(COUNT(microdata_item_type)) OVER (PARTITION BY client) AS pct_microdata,
  COUNT(DISTINCT url) AS freq_pages,
  total_pages,
  COUNT(DISTINCT url) / total_pages AS pct_pages
FROM (
  SELECT
    client,
    url,
    -- Removes the protocol and any subdomains from the URL.
    -- e.g. "https://my.example.com/pathname" becomes "example.com/pathname"
    -- This is done to normalize the URL a bit before counting.
    CONCAT(NET.REG_DOMAIN(microdata_item_type), SPLIT(microdata_item_type, NET.REG_DOMAIN(microdata_item_type))[SAFE_OFFSET(1)]) AS microdata_item_type
  FROM
    rendered_data,
    UNNEST(microdata_item_types) AS microdata_item_type
)
JOIN
  page_totals
USING (client)
GROUP BY
  client,
  microdata_item_type,
  total_pages
ORDER BY
  freq_microdata DESC,
  client
