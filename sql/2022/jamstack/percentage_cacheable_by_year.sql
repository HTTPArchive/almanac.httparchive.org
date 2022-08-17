WITH cacheable AS (
  SELECT
    client,
    date,
    COUNT(DISTINCT(url)) AS urls
  FROM
    `httparchive.almanac.requests`
  WHERE
    firstHtml AND
    (
      (
        resp_age IS NOT NULL AND
        resp_age != '' AND
        safe_cast(resp_age AS NUMERIC) > 0
      )
      OR
      (
        resp_cache_control IS NOT NULL AND
        resp_cache_control != '' AND
        expAge IS NOT NULL AND
        resp_cache_control NOT LIKE 'no-store' AND
        resp_cache_control NOT LIKE 'no-cache' AND
        expAge > 0
      )
    )
  GROUP BY
    client,
    date
),

all_sites AS (
  SELECT
    client,
    date,
    COUNT(DISTINCT(url)) AS urls
  FROM
    `httparchive.almanac.requests`
  WHERE
    firstHtml
  GROUP BY
    client,
    date
)

SELECT
  c.client,
  c.date,
  c.urls AS cacheable,
  a.urls AS all_urls,
  c.urls / a.urls AS percent_cacheable
FROM
  cacheable c
JOIN
  all_sites a
USING (client, date)
ORDER BY
  client,
  date
