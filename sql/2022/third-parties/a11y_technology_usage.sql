#standardSQL
# A11Y technology usage

SELECT
  client,
  freq,
  total,
  freq / total AS pct
FROM (
  SELECT
    _TABLE_SUFFIX AS client,
    COUNT(DISTINCT url) AS freq
  FROM
    `httparchive.technologies.2022_06_01_*`
  WHERE
    category = 'Accessibility'
  GROUP BY
    client
)
JOIN (
  SELECT
    _TABLE_SUFFIX AS client,
    COUNT(0) AS total
  FROM
    `httparchive.summary_pages.2022_06_01_*`
  GROUP BY
    client
)
USING (client)
