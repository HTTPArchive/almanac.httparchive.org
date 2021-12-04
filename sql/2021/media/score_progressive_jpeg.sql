#standardSQL
# percent of pages with score_progressive_jpeg
# -1, 0 - 25, 25 - 50, 50 - 75, 75 - 100

SELECT
  client,
  COUNTIF(score < 0) / COUNT(0) AS percent_negative,
  COUNTIF(score >= 0 AND score < 25) / COUNT(0) AS percent_0_25,
  COUNTIF(score >= 25 AND score < 50) / COUNT(0) AS percent_25_50,
  COUNTIF(score >= 50 AND score < 75) / COUNT(0) AS percent_50_75,
  COUNTIF(score >= 75 AND score <= 100) / COUNT(0) AS percent_75_100
FROM (
  SELECT
    _TABLE_SUFFIX AS client,
    CAST(JSON_EXTRACT(payload, '$._score_progressive_jpeg') AS INT64) AS score
  FROM
    `httparchive.pages.2021_07_01_*`)
GROUP BY
  client
ORDER BY
  client
