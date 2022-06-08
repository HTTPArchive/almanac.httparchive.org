SELECT
  DATE('2022-06-01') AS date,
  NET.HOST(url) AS host,
  NET.REG_DOMAIN(url) AS domain,
  *
FROM
  # This is the raw database dump from GWF.
  `httparchive.almanac.green_web_foundation_raw`
