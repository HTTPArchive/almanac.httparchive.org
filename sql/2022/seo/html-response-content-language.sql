#standardSQL
# HTML response: content language

SELECT
  _TABLE_SUFFIX AS client,
  LOWER(resp_content_language) AS resp_content_language,
  COUNT(0) AS freq,
  SAFE_DIVIDE(COUNT(0), SUM(COUNT(0)) OVER (PARTITION BY _TABLE_SUFFIX)) AS pct
FROM
  `httparchive.summary_requests.2022_07_01_*` -- noqa: CV09
WHERE
  firstHtml
GROUP BY
  client,
  resp_content_language
QUALIFY
  freq >= 100
ORDER BY
  freq DESC,
  client
