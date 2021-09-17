#standardSQL
SELECT
  IF(ENDS_WITH(_TABLE_SUFFIX, 'desktop'), 'desktop', 'mobile') AS client,
  SUBSTRING(url, 1, 400) AS url,
  respHeadersSize / 1024 AS respHeadersSizeKiB
FROM
  `httparchive.summary_requests.*`
WHERE
  respHeadersSize IS NOT NULL AND
  _TABLE_SUFFIX LIKE "2021_07_01%"
ORDER BY
  respHeadersSizeKiB DESC
LIMIT 200
