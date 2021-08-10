#standardSQL
# Distribution of page weight, requests, and co2 grams per SSG web page
# https://gitlab.com/wholegrain/carbon-api-2-0/-/blob/b498ec3bb239536d3612c5f3d758f46e0d2431a6/includes/carbonapi.php
CREATE TEMP FUNCTION
  GREEN(url STRING) AS (FALSE); -- TODO: Investigate fetching from Green Web Foundation
CREATE TEMP FUNCTION
  adjustDataTransfer(val INT64) AS (val * 0.75 + 0.02 * val * 0.25);
CREATE TEMP FUNCTION
  energyConsumption(bytes FLOAT64) AS (bytes * 1.805 / 1073741824);
CREATE TEMP FUNCTION
  getCo2Grid(energy FLOAT64) AS (energy * 475);
CREATE TEMP FUNCTION
  getCo2Renewable(energy FLOAT64) AS (energy * 0.1008 * 33.4 + energy * 0.8992 * 475);
CREATE TEMP FUNCTION
  CO2(url STRING, bytes INT64) AS (
  IF(GREEN(url),
      getCo2Renewable(energyConsumption(adjustDataTransfer(bytes))),
      getCo2Grid(energyConsumption(adjustDataTransfer(bytes)))));

SELECT
  percentile,
  client,
  APPROX_QUANTILES(requests, 1000)[OFFSET(percentile * 10)] AS requests,
  ROUND(APPROX_QUANTILES(bytes, 1000)[OFFSET(percentile * 10)] / 1024 / 1024, 2) AS mbytes,
  APPROX_QUANTILES(co2grams, 1000)[OFFSET(percentile * 10)] AS co2grams
FROM (
  SELECT
    _TABLE_SUFFIX AS client,
    reqTotal AS requests,
    bytesTotal AS bytes,
    CO2(url, bytesTotal) AS co2grams
  FROM
    `httparchive.summary_pages.2020_08_01_*`
  JOIN (
    SELECT
      _TABLE_SUFFIX,
      url
    FROM
      `httparchive.technologies.2020_08_01_*`
    WHERE
      LOWER(category) = "static site generator" OR
      app = "Next.js" OR
      app = "Nuxt.js" OR
      app = "Docusaurus"
  )
  USING
    (_TABLE_SUFFIX, url)),
  UNNEST([10, 25, 50, 75, 90]) AS percentile
GROUP BY
  percentile,
  client
ORDER BY
  percentile,
  client
