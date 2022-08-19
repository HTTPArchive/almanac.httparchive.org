#standardSQL
# Pages that request DNT status

SELECT
  _TABLE_SUFFIX AS client,
  SUM(IF(JSON_QUERY(JSON_VALUE(payload, '$._privacy'), '$.document_interestCohort') = 'true', 1, 0)) AS num_urls,
  SUM(IF(JSON_QUERY(JSON_VALUE(payload, '$._privacy'), '$.document_interestCohort') = 'true', 1, 0)) / COUNT(DISTINCT url) AS pct_urls
FROM
  `httparchive.pages.2022_06_01_*`
GROUP BY 1
