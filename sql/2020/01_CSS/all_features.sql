#standardSQL
# % of sites that use each Blink feature (for @supports usage and more)
SELECT
  client,
  feature,
  SUM(feature_freq) as freq,
  total,
  SUM(feature_freq) * 100 / total as pct_pages
FROM (
  SELECT
    client,
    feature,
    COUNT(DISTINCT url) AS feature_freq
  FROM
    `httparchive.blink_features.features`
  WHERE
    yyyymmdd = '20200801'
  GROUP BY
    client,
    feature)
JOIN
  (SELECT _TABLE_SUFFIX AS client, COUNT(0) AS total FROM `httparchive.summary_pages.2020_08_01_*` GROUP BY client)
USING
  (client)
GROUP BY
  client,
  feature,
  total
ORDER BY pct_pages DESC
