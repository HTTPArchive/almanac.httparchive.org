SELECT
  _TABLE_SUFFIX AS client,
  REGEXP_CONTAINS(LOWER(IFNULL(resp_vary, '')), r'user-agent') AS resp_vary_user_agent,
  COUNT(0) AS freq,
  SAFE_DIVIDE(COUNT(0), SUM(COUNT(0)) OVER (PARTITION BY _TABLE_SUFFIX)) AS pct
FROM
  `httparchive.summary_requests.2022_07_01_*` -- noqa: CV09
WHERE
  firstHtml
GROUP BY
  client,
  resp_vary_user_agent
ORDER BY
  freq DESC,
  client
