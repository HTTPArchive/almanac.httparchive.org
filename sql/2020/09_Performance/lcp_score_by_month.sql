#standardSQL
  # Largest contentful paint score thresholds by month

SELECT
  *
FROM (
  SELECT
    date,
    device,
    ROW_NUMBER() OVER (PARTITION BY date, device ORDER BY lcp_value ASC) AS percentile,
    lcp_value
  FROM (
    SELECT
      DATE("2020-06-01") AS date,
      "desktop" AS device,
      APPROX_QUANTILES(CAST(JSON_EXTRACT_SCALAR(payload, "$['_chromeUserTiming.LargestContentfulPaint']") AS NUMERIC), 100) AS lcp,
    FROM
      `httparchive.pages.2020_06_01_desktop`
    UNION ALL
    SELECT
      DATE("2020-06-01") AS date,
      "mobile" AS device,
      APPROX_QUANTILES(CAST(JSON_EXTRACT_SCALAR(payload, "$['_chromeUserTiming.LargestContentfulPaint']") AS NUMERIC), 100) AS lcp,
    FROM
      `httparchive.pages.2020_06_01_mobile`),
  UNNEST(lcp) lcp_value)
WHERE
  percentile IN (5, 25)