WITH
fonts AS (
  SELECT
    url,
    client,
    REGEXP_CONTAINS(JSON_EXTRACT(payload, '$._font_details.table_sizes'), '(?i)GPOS|GSUB') AS has_ot_features
  FROM
    `httparchive.almanac.requests`
  WHERE
    date = '2022-06-01' AND
    type = 'font'
  GROUP BY
    url,
    client,
    has_ot_features
)

SELECT
  client,
  has_ot_features,
  COUNT(0) AS freq,
  SUM(COUNT(0)) OVER (PARTITION BY client) AS total,
  COUNT(0) / SUM(COUNT(0)) OVER (PARTITION BY client) AS pct_freq
FROM
  fonts
GROUP BY
  client,
  has_ot_features
ORDER BY
  pct_freq DESC
