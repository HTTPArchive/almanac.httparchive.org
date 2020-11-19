#standardSQL
--share of cryptominers
WITH
  total AS (
  SELECT
    COUNT(0) AS ttl
  FROM
    `httparchive.technologies.2020_08_01_desktop`
  WHERE
    category = 'Cryptominers'
    OR category='Cryptominer')
SELECT
  app,
  freq,
  ROUND((freq/(
      SELECT
        ttl
      FROM
        total)),2) AS pct
FROM (
  SELECT
    SUM(freq) AS freq,
    app
  FROM (
    SELECT
      COUNT(0) AS freq,
      app
    FROM
      `httparchive.technologies.2020_08_01_desktop`
    WHERE
      category = 'Cryptominers'
      OR category='Cryptominer'
    GROUP BY
      app)
  GROUP BY
    app)
ORDER BY
  pct DESC
