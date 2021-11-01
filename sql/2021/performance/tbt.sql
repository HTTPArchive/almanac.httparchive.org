#standardSQL
# TBT data by threshold

CREATE TEMP FUNCTION getTbtThreshold (lighthouseTbtScore FLOAT64) RETURNS STRING LANGUAGE js AS '''
  if (lighthouseTbtScore >= 0.75) {
      return 'GOOD'
  } else if (lighthouseTbtScore >= 0.25) {
      return 'NI'
  } else if (lighthouseTbtScore >= 0) {
      return 'POOR'
  } else {
      return 'NA'
  }
''';

WITH
tbt_stats AS (
  SELECT
    url,
    getTbtThreshold(CAST(JSON_EXTRACT_SCALAR(report, "$.audits.total-blocking-time.score") AS FLOAT64)) AS threshold
  FROM
    `httparchive.lighthouse.2021_07_01_mobile`
)

SELECT
  threshold,
  COUNT(DISTINCT url) AS pages,
FROM
  tbt_stats
GROUP BY
  threshold
