SELECT
  DATE('2022-06-01') AS date,
  NET.HOST(LOWER(url)) AS host,
  NET.REG_DOMAIN(LOWER(url)) AS domain,
  * -- noqa: L013
FROM
  # This is the raw database dump from GWF.
  `httparchive.almanac.green_web_foundation_raw`
