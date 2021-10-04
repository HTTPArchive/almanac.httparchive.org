#standardSQL
SELECT
  _TABLE_SUFFIX AS client,
  SUBSTRING(url, 1, 400) AS url,
  respHeadersSize / 1024 AS respHeadersSizeKiB
FROM
  `httparchive.summary_requests.2021_07_01_*`
WHERE
  respHeadersSize IS NOT NULL
ORDER BY
  respHeadersSizeKiB DESC
LIMIT 200
