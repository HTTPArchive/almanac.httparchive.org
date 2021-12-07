#standardSQL
#variable_font_comparison_fcp
SELECT
  client,
  variable_fonts > 0 AS uses_variable_fonts,
  COUNT(DISTINCT IF(variable_fonts > 0, page, NULL)) AS pages_with_variable_fonts,
  total,
  COUNT(DISTINCT IF(variable_fonts > 0, page, NULL)) / total AS pct,
  APPROX_QUANTILES(fcp, 1000)[OFFSET(500)] AS median_fcp,
  APPROX_QUANTILES(lcp, 1000)[OFFSET(500)] AS median_lcp
FROM (
  SELECT
    client,
    page,
    COUNTIF(REGEXP_CONTAINS(JSON_EXTRACT(payload, '$._font_details.table_sizes'), '(?i)gvar')) AS variable_fonts
  FROM
    `httparchive.almanac.requests`
  WHERE
    date = '2020-09-01'
  GROUP BY
    client,
    page)
JOIN (
  SELECT
    _TABLE_SUFFIX AS client,
    url AS page,
    CAST(JSON_EXTRACT_SCALAR(payload, "$['_chromeUserTiming.firstContentfulPaint']") AS INT64) AS fcp,
    CAST(JSON_EXTRACT_SCALAR(payload, "$['_chromeUserTiming.LargestContentfulPaint']") AS INT64) AS lcp
  FROM
    `httparchive.pages.2020_09_01_*`
  GROUP BY
    _TABLE_SUFFIX, url, payload )
USING
  (client, page)
JOIN (
  SELECT
    _TABLE_SUFFIX AS client,
    COUNT(0) AS total
  FROM
    `httparchive.pages.2020_09_01_*`
  GROUP BY
    _TABLE_SUFFIX )
USING
  (client)
GROUP BY
  client,
  total,
  uses_variable_fonts
