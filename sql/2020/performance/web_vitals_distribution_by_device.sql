#standardSQL
# WebVitals distribution by device

WITH
base AS (
  SELECT
    device,

    fast_fid,
    avg_fid,
    slow_fid,

    fast_lcp,
    avg_lcp,
    slow_lcp,

    small_cls,
    medium_cls,
    large_cls,

    fast_fcp,
    avg_fcp,
    slow_fcp,

    fast_ttfb,
    avg_ttfb,
    slow_ttfb

  FROM
    `chrome-ux-report.materialized.device_summary`
  WHERE
    device IN ('desktop', 'phone') AND
    date = '2020-08-01'
),

fid AS (
  SELECT
    device,
    fast_fid,
    avg_fid,
    slow_fid,
    ROW_NUMBER() OVER (PARTITION BY device ORDER BY fast_fid DESC) AS row
  FROM (
    SELECT
      device,
      SAFE_DIVIDE(fast_fid, fast_fid + avg_fid + slow_fid) AS fast_fid,
      SAFE_DIVIDE(avg_fid, fast_fid + avg_fid + slow_fid) AS avg_fid,
      SAFE_DIVIDE(slow_fid, fast_fid + avg_fid + slow_fid) AS slow_fid,
      ROW_NUMBER() OVER (PARTITION BY device ORDER BY fast_fid DESC) AS row,
      COUNT(0) OVER (PARTITION BY device) AS n
    FROM
      base
    WHERE
      fast_fid + avg_fid + slow_fid > 0
  )
  WHERE
    MOD(row, CAST(FLOOR(n / 1000) AS INT64)) = 0
),

lcp AS (
  SELECT
    device,
    fast_lcp,
    avg_lcp,
    slow_lcp,
    ROW_NUMBER() OVER (PARTITION BY device ORDER BY fast_lcp DESC) AS row
  FROM (
    SELECT
      device,
      SAFE_DIVIDE(fast_lcp, fast_lcp + avg_lcp + slow_lcp) AS fast_lcp,
      SAFE_DIVIDE(avg_lcp, fast_lcp + avg_lcp + slow_lcp) AS avg_lcp,
      SAFE_DIVIDE(slow_lcp, fast_lcp + avg_lcp + slow_lcp) AS slow_lcp,
      ROW_NUMBER() OVER (PARTITION BY device ORDER BY fast_lcp DESC) AS row,
      COUNT(0) OVER (PARTITION BY device) AS n
    FROM
      base
    WHERE
      fast_lcp + avg_lcp + slow_lcp > 0
  )
  WHERE
    MOD(row, CAST(FLOOR(n / 1000) AS INT64)) = 0
),

cls AS (
  SELECT
    device,
    small_cls,
    medium_cls,
    large_cls,
    ROW_NUMBER() OVER (PARTITION BY device ORDER BY small_cls DESC) AS row
  FROM (
    SELECT
      device,
      SAFE_DIVIDE(small_cls, small_cls + medium_cls + large_cls) AS small_cls,
      SAFE_DIVIDE(medium_cls, small_cls + medium_cls + large_cls) AS medium_cls,
      SAFE_DIVIDE(large_cls, small_cls + medium_cls + large_cls) AS large_cls,
      ROW_NUMBER() OVER (PARTITION BY device ORDER BY small_cls DESC) AS row,
      COUNT(0) OVER (PARTITION BY device) AS n
    FROM
      base
    WHERE
      small_cls + medium_cls + large_cls > 0
  )
  WHERE
    MOD(row, CAST(FLOOR(n / 1000) AS INT64)) = 0
),

fcp AS (
  SELECT
    device,
    fast_fcp,
    avg_fcp,
    slow_fcp,
    ROW_NUMBER() OVER (PARTITION BY device ORDER BY fast_fcp DESC) AS row
  FROM (
    SELECT
      device,
      SAFE_DIVIDE(fast_fcp, fast_fcp + avg_fcp + slow_fcp) AS fast_fcp,
      SAFE_DIVIDE(avg_fcp, fast_fcp + avg_fcp + slow_fcp) AS avg_fcp,
      SAFE_DIVIDE(slow_fcp, fast_fcp + avg_fcp + slow_fcp) AS slow_fcp,
      ROW_NUMBER() OVER (PARTITION BY device ORDER BY fast_fcp DESC) AS row,
      COUNT(0) OVER (PARTITION BY device) AS n
    FROM
      base
    WHERE
      fast_fcp + avg_fcp + slow_fcp > 0
  )
  WHERE
    MOD(row, CAST(FLOOR(n / 1000) AS INT64)) = 0
),

ttfb AS (
  SELECT
    device,
    fast_ttfb,
    avg_ttfb,
    slow_ttfb,
    ROW_NUMBER() OVER (PARTITION BY device ORDER BY fast_ttfb DESC) AS row
  FROM (
    SELECT
      device,
      SAFE_DIVIDE(fast_ttfb, fast_ttfb + avg_ttfb + slow_ttfb) AS fast_ttfb,
      SAFE_DIVIDE(avg_ttfb, fast_ttfb + avg_ttfb + slow_ttfb) AS avg_ttfb,
      SAFE_DIVIDE(slow_ttfb, fast_ttfb + avg_ttfb + slow_ttfb) AS slow_ttfb,
      ROW_NUMBER() OVER (PARTITION BY device ORDER BY fast_ttfb DESC) AS row,
      COUNT(0) OVER (PARTITION BY device) AS n
    FROM
      base
    WHERE
      fast_ttfb + avg_ttfb + slow_ttfb > 0
  )
  WHERE
    MOD(row, CAST(FLOOR(n / 1000) AS INT64)) = 0
)

SELECT
  device,
  row,

  fast_fid,
  avg_fid,
  slow_fid,

  small_cls,
  medium_cls,
  large_cls,

  fast_lcp,
  avg_lcp,
  slow_lcp,

  fast_fcp,
  avg_fcp,
  slow_fcp,

  fast_ttfb,
  avg_ttfb,
  slow_ttfb
FROM
  fid
FULL JOIN
  lcp
USING (row, device)
FULL JOIN
  cls
USING (row, device)
FULL JOIN
  fcp
USING (row, device)
FULL JOIN
  ttfb
USING (row, device)
ORDER BY
  device,
  row
