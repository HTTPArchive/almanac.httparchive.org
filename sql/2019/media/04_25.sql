#standardSQL
# 04_25: % of pages having WebXR frameworks
SELECT
  client,
  framework,
  COUNT(DISTINCT page) AS pages
FROM (
  SELECT
    client,
    page,
    REGEXP_EXTRACT(LOWER(url), '(aframe|babylon|argon)(?:\\.min)?\\.js') AS framework
  FROM
    `httparchive.almanac.requests`
  WHERE
    date = '2019-07-01' AND
    type = 'script'
)
WHERE
  framework IS NOT NULL
GROUP BY
  client,
  framework
