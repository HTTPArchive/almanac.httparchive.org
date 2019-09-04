#standardSQL

-- counts the number of pages given number of font-face

#standardSQL
SELECT
  APPROX_QUANTILES(fonts_per_page, 1000)[OFFSET(250)] AS p25_fonts_per_page,
  APPROX_QUANTILES(fonts_per_page, 1000)[OFFSET(500)] AS median_fonts_per_page,
  APPROX_QUANTILES(fonts_per_page, 1000)[OFFSET(750)] AS p75_fonts_per_page
FROM (
  SELECT
    COUNT(0) AS fonts_per_page
  FROM
    `httparchive.summary_requests.2019_07_01_*`
  WHERE
    type = 'font'
  GROUP BY
    pageid)
