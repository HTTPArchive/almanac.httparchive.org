#standardSQL
# Sum of JS request bytes per page by framework
SELECT
  percentile,
  client,
  app AS js_framework,
  COUNT(DISTINCT page) AS pages,
  APPROX_QUANTILES(bytesJs / 1024, 1000)[OFFSET(percentile * 10)] AS js_kilobytes
FROM (
  SELECT
    _TABLE_SUFFIX AS client,
    url AS page,
    bytesJs
  FROM
    `httparchive.summary_pages.2022_06_01_*`
)
JOIN (
  SELECT DISTINCT
    _TABLE_SUFFIX AS client,
    url AS page,
    app
  FROM
    `httparchive.technologies.2022_06_01_*`
  WHERE
    category = 'JavaScript frameworks'
)
USING (client, page),
  UNNEST([10, 25, 50, 75, 90]) AS percentile
GROUP BY
  percentile,
  client,
  js_framework
ORDER BY
  client,
  percentile,
  pages DESC
