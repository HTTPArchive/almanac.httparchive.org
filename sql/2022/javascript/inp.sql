#standardSQL
# INP by device

CREATE TEMP FUNCTION IS_NON_ZERO (p75_inp FLOAT64, p75_inp_origin FLOAT64) RETURNS BOOL AS (
  p75_inp + p75_inp_origin > 0
);

WITH
base AS (
  SELECT
    device,
    p75_inp,
    p75_inp_origin
  FROM
    `chrome-ux-report.materialized.device_summary`
  WHERE
    device IN ('desktop', 'phone') AND
    date IN ('2022-06-01') AND
    IS_NON_ZERO(p75_inp, p75_inp_origin)
)

SELECT
  device,
  percentile,
  APPROX_QUANTILES(p75_inp, 1000)[OFFSET(percentile * 10)] AS p75_inp,
  APPROX_QUANTILES(p75_inp_origin, 1000)[OFFSET(percentile * 10)] AS p75_inp_origin
FROM
  base,
  UNNEST([10, 25, 50, 75, 90, 100]) AS percentile
GROUP BY
  device,
  percentile
ORDER BY
  device,
  percentile
