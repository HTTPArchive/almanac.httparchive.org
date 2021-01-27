#standardSQL
# Percent of websites with CMP

WITH base AS (
  SELECT
    _TABLE_SUFFIX AS client,
    url,
    LOGICAL_OR(category = "Cookie compliance") AS with_cmp
  FROM `httparchive.technologies.2020_08_01_*`
  GROUP BY
    client,
    url
)

SELECT
  client,
  COUNT(url) AS total_pages,
  COUNTIF(with_cmp) / COUNT(url) AS pct_websites_with_cmp
FROM
  base
GROUP BY
  client
