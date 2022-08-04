#standardSQL
# FID by device

CREATE TEMP FUNCTION IS_NON_ZERO (p75_fid FLOAT64, p75_fid_origin FLOAT64) RETURNS BOOL AS (
  p75_fid + p75_fid_origin > 0
);

WITH
base AS (
  SELECT
    device,
    p75_fid,
    p75_fid_origin
  FROM
    `chrome-ux-report.materialized.device_summary`
  WHERE
    device IN ('desktop', 'phone') AND
    date IN ('2022-06-01') AND
    IS_NON_ZERO(p75_fid, p75_fid_origin)
)

SELECT
  device,
  percentile,
  APPROX_QUANTILES(p75_fid, 1000)[OFFSET(percentile * 10)] AS p75_fid,
  APPROX_QUANTILES(p75_fid_origin, 1000)[OFFSET(percentile * 10)] AS p75_fid_origin
FROM
  base,
  UNNEST([10, 25, 50, 75, 90, 100]) AS percentile
GROUP BY
  device,
  percentile
ORDER BY
  device,
  percentile
