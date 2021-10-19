#standardSQL
# Total page weight distribution by CMS
SELECT
  percentile,
  client,
  cms,
  COUNT(0) AS pages,
  APPROX_QUANTILES(total_kb, 1000)[OFFSET(percentile * 10)] AS total_kb
FROM (
  SELECT DISTINCT
    _TABLE_SUFFIX AS client,
    url,
    app AS cms
  FROM
    `httparchive.technologies.2021_07_01_*`
  WHERE
    category = 'CMS')
JOIN (
  SELECT
    _TABLE_SUFFIX AS client,
    url,
    bytesTotal / 1024 AS total_kb
  FROM
    `httparchive.summary_pages.2021_07_01_*`)
USING
  (client, url),
  UNNEST([10, 25, 50, 75, 90, 100]) AS percentile
GROUP BY
  percentile,
  client,
  cms
HAVING
  pages > 1000
ORDER BY
  percentile,
  pages DESC
