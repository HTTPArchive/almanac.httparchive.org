#standardSQL
# Distribution OF WordPress resource types BY path
# wordpress_resources.sql
# Updated to use the new crawl dataset

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
    -- Get WordPress pages
    SELECT
      client,
      page
    FROM
      `httparchive.crawl.pages`,
      UNNEST(technologies) AS technologies
    WHERE
      technologies.technology = 'WordPress' AND
      date = '2025-06-01' AND
      is_root_page
  ) wp_pages
  JOIN (
    -- Get all requests for WordPress pages
    SELECT
      client,
      page,
      url,
      REGEXP_EXTRACT(url, r'/(themes|plugins|wp-includes)/') AS path
    FROM
      `httparchive.crawl.requests`
    WHERE
      date = '2025-06-01' AND
      is_root_page
  ) requests
  USING (client, page)
  WHERE
    path IS NOT NULL
  GROUP BY
    client,
    page,
    path
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
