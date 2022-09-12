WITH
fonts AS (
  SELECT
    url,
    REGEXP_CONTAINS(JSON_EXTRACT(payload, '$._font_details.table_sizes'), '(?i)GPOS|GSUB') AS has_ot_features
  FROM
    `httparchive.almanac.requests`
  WHERE
    date = '2022-06-01' AND
    type = 'font'
  GROUP BY
    url,
    has_ot_features
)

SELECT
  has_ot_features,
  COUNT(0) AS freq,
  COUNT(0) / SUM(COUNT(0)) OVER () AS pct_freq
FROM
  fonts
GROUP BY
  has_ot_features
ORDER BY
  pct_freq DESC
