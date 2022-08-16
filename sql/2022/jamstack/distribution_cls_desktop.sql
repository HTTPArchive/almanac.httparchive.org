-- getting distribution of LCP times to calculate median LCP time
-- or whatever other threshold we decide looks reasonable
WITH cls_times AS (
  SELECT
    origin AS url,
    p75_cls AS cls
  FROM `chrome-ux-report.materialized.device_summary`
  WHERE date = '2022-06-01'
  AND device = 'desktop'
)

SELECT
  cls,
  count(distinct(url)) AS urls
FROM cls_times
WHERE cls IS NOT NULL
GROUP BY cls
ORDER BY cls
