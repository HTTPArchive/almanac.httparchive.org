WITH lcp_only AS (
  SELECT
    IF(device = 'phone', 'mobile', device) AS client,
    date,
    COUNT(DISTINCT(origin)) AS urls
  FROM
    `chrome-ux-report.materialized.device_summary`
  WHERE (device = 'phone' AND p75_lcp <= 2400) OR (device = 'desktop' AND p75_lcp <= 2000)
  GROUP BY
    client,
    date
),

cls_only AS (
  SELECT
    IF(device = 'phone', 'mobile', device) AS client,
    date,
    COUNT(DISTINCT(origin)) AS urls
  FROM
    `chrome-ux-report.materialized.device_summary`
  WHERE (device = 'phone' AND p75_cls < 0.05) OR (device = 'desktop' AND p75_cls < 0.05) AND
    device IN ('phone', 'desktop')
  GROUP BY
    client,
    date
),

cacheable AS (
  SELECT
    client,
    date,
    COUNT(DISTINCT(url)) AS urls
  FROM
    `httparchive.almanac.requests`
  WHERE
    firstHtml AND ((
      resp_age IS NOT NULL AND
      resp_age != '' AND
      safe_cast(resp_age AS NUMERIC) > 0
    ) OR (
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

all_crux_urls AS (
  SELECT
    IF(device = 'phone', 'mobile', device) AS client,
    date,
    COUNT(DISTINCT(origin)) AS crux_urls
  FROM
    `chrome-ux-report.materialized.device_summary`
  WHERE
    device IN ('phone', 'desktop')
  GROUP BY
    client,
    date
),

all_ha_urls AS (
  SELECT
    IF(ENDS_WITH(_TABLE_SUFFIX, 'desktop'), 'desktop', 'mobile') AS client,
    CAST(REGEXP_REPLACE(_TABLE_SUFFIX, r'(\d+)_(\d+)_(\d+).*', r'\1-\2-\3') AS DATE) AS date,
    REGEXP_REPLACE(_TABLE_SUFFIX, r'(\d+)_(\d+)_(\d+).*', r'\1') AS year,
    COUNT(DISTINCT(url)) AS ha_urls
  FROM
    `httparchive.summary_pages.*`
  WHERE
    _TABLE_SUFFIX LIKE '2020_08_01%' OR
    _TABLE_SUFFIX LIKE '2021_07_01%' OR
    _TABLE_SUFFIX LIKE '2022_06_01%'
  GROUP BY
    client,
    date,
    year
)

SELECT
  a.client,
  a.date,
  a.year,
  a.ha_urls AS ha_urls,
  cu.crux_urls AS crux_urls,
  l.urls AS lcp_matches,
  c.urls AS cls_matches,
  cu.crux_urls AS cacheable,
  l.urls / cu.crux_urls AS lcp_percent_match,
  c.urls / cu.crux_urls AS cls_percent_match,
  ca.urls / a.ha_urls AS cacheable_percent_match
FROM
  all_ha_urls a
JOIN
  all_crux_urls cu
USING (client, date)
JOIN
  lcp_only l
USING (client, date)
JOIN
  cls_only c
USING (client, date)
JOIN
  cacheable ca
USING (client, date)
ORDER BY
  client,
  date
