#standardSQL

# Percentiles of visually complete metric

SELECT 
ROUND(APPROX_QUANTILES(visualComplete, 1001)[OFFSET(101)] / 1000, 2) AS p10,
ROUND(APPROX_QUANTILES(visualComplete, 1001)[OFFSET(251)] / 1000, 2) AS p25,
ROUND(APPROX_QUANTILES(visualComplete, 1001)[OFFSET(501)] / 1000, 2) AS p50,
ROUND(APPROX_QUANTILES(visualComplete, 1001)[OFFSET(751)] / 1000, 2) AS p75,
ROUND(APPROX_QUANTILES(visualComplete, 1001)[OFFSET(901)] / 1000, 2) AS p90
FROM
httparchive.almanac.summary_pages_desktop_1k
