#standardSQL
# Distribution of WordPress resource types by path
SELECT
  percentile,
  client,
  path,
  APPROX_QUANTILES(freq, 1000)[OFFSET(percentile * 10)] AS freq
FROM (
  SELECT
    _TABLE_SUFFIX AS client,
    page,
    REGEXP_EXTRACT(url, r'/(themes|plugins|wp-includes)/') AS path,
    COUNT(0) AS freq
  FROM (SELECT _TABLE_SUFFIX, url AS page FROM `httparchive.technologies.2021_07_01_*` WHERE app = 'WordPress')
  JOIN (SELECT _TABLE_SUFFIX, pageid, url AS page FROM `httparchive.summary_pages.2021_07_01_*`)
  USING (_TABLE_SUFFIX, page)
  JOIN (SELECT _TABLE_SUFFIX, pageid, url FROM `httparchive.summary_requests.2021_07_01_*`)
  USING (_TABLE_SUFFIX, pageid)
  GROUP BY
    client,
    page,
    path
  HAVING
    path IS NOT NULL
),
  UNNEST([10, 25, 50, 75, 90, 100]) AS percentile
GROUP BY
  percentile,
  client,
  path
ORDER BY
  percentile,
  client,
  path
