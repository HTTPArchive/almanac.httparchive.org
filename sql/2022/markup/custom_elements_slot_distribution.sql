WITH totals AS (
  SELECT
    _TABLE_SUFFIX,
    COUNT(0) AS total
  FROM
    `httparchive.summary_pages.2022_06_01_*`
  GROUP BY
    _TABLE_SUFFIX
)

SELECT
  _TABLE_SUFFIX AS client,
  CAST(num_slots AS INT64) AS num_slots,
  COUNT(0) AS freq,
  SUM(COUNT(0)) OVER (PARTITION BY _TABLE_SUFFIX) AS total,
  COUNT(0) / SUM(COUNT(0)) OVER (PARTITION BY _TABLE_SUFFIX) AS pct,
  COUNT(DISTINCT url) AS pages,
  ANY_VALUE(total) AS total_pages,
  COUNT(DISTINCT url) / ANY_VALUE(total) AS pct_pages
FROM
  `httparchive.pages.2022_06_01_*`,
  UNNEST(JSON_VALUE_ARRAY(JSON_VALUE(payload, '$._wpt_bodies'), '$.web_components.raw.hyphenatedElements.slots')) AS num_slots
JOIN
  totals
USING (_TABLE_SUFFIX)
GROUP BY
  client,
  num_slots
ORDER BY
  num_slots,
  client
