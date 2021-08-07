#standardSQL
# if header contains vary by user-agent

CREATE TEMP FUNCTION AS_PERCENT (freq FLOAT64, total FLOAT64) RETURNS FLOAT64 AS (
  ROUND(SAFE_DIVIDE(freq, total), 4)
);

SELECT
  _TABLE_SUFFIX AS client,
  LOWER(resp_content_language) AS resp_content_language,
  COUNT(0) AS freq,
  AS_PERCENT(COUNT(0), SUM(COUNT(0)) OVER (PARTITION BY _TABLE_SUFFIX)) AS pct
FROM
   `httparchive.summary_requests.2020_08_01_*`
WHERE
   firstHtml
GROUP BY
  client,
  resp_content_language
HAVING
  freq >= 100
ORDER BY
  freq DESC,
  client
