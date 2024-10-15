#standardSQL 
# Distribution OF WordPress resource types BY path 
# wordpress_resources.sql

SELECT
  percentile,
  client,
  path,
  APPROX_QUANTILES(freq, 1000)[OFFSET(percentile * 10)] AS freq
FROM (
  SELECT
    client,
    page,
    REGEXP_EXTRACT(url, r'/(themes|plugins|wp-includes)/') AS path,
    COUNT(0) AS freq
  FROM (
    SELECT
      client,
      page
    FROM
      `httparchive.all.pages`,
      UNNEST(technologies) AS technologies,
      UNNEST(technologies.categories) AS cats
    WHERE
      technologies.technology = 'WordPress' AND
      date = '2024-06-01')
  JOIN (
    SELECT
      client,
      cast(json_value(summary, '$.pageid') AS INT64) AS pageid,
      page
    FROM
      `httparchive.all.pages`,
      UNNEST(technologies) AS technologies,
      UNNEST(technologies.categories) AS cats
    WHERE
      date = '2024-06-01')
  USING
    (client,
      page)
  JOIN (
    SELECT
      client,
      cast(json_value(summary, '$.pageid') AS INT64) AS pageid,
      page AS url
    FROM
      `httparchive.all.pages`
    WHERE
      date = '2024-06-01')
  USING
    (client,
      pageid)
  GROUP BY
    client,
    page,
    path
  HAVING
    path IS NOT NULL),
  UNNEST([10, 25, 50, 75, 90, 100]) AS percentile
GROUP BY
  percentile,
  client,
  path
ORDER BY
  percentile,
  client,
  path
