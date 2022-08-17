WITH cls_only AS (
  SELECT
    device AS client,
    date,
    count(distinct(origin)) AS urls
  FROM `chrome-ux-report.materialized.device_summary`
  WHERE
    p75_cls < 0.05
  GROUP BY
    client,
    date
),

all_urls AS (
  SELECT
    device AS client,
    date,
    count(distinct(origin)) AS urls
  FROM `chrome-ux-report.materialized.device_summary`
  GROUP BY
    client,
    date
)

SELECT
  c.client,
  c.date,
  c.urls AS cls_matches,
  a.urls AS all_urls,
  c.urls / a.urls AS percent_match
FROM cls_only c
JOIN all_urls a
USING (client, date)
ORDER BY client, date
