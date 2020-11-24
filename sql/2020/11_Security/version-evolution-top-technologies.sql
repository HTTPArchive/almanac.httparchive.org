#standardSQL
# Distribution of the different version of the top 20 technologies used on the web.

SELECT
  category,
  app,
  info,
  month,
  client,
  pct
FROM (
  SELECT
    info,
    tech.category AS category,
    tech.app AS app,
    LEFT(_TABLE_SUFFIX, 10) AS month,
    IF(ENDS_WITH(_TABLE_SUFFIX, '_desktop'), 'desktop', 'mobile') AS client,
    COUNT(0) / SUM(COUNT(0)) OVER (PARTITION BY _TABLE_SUFFIX, tech.category, tech.app) AS pct
  FROM
    `httparchive.technologies.*` AS tech
  INNER JOIN (
    SELECT
      category,
      app,
      COUNT(0) AS num
    FROM
      `httparchive.technologies.*`
    WHERE
      REGEXP_CONTAINS(_TABLE_SUFFIX, r'^20(20|19).*')
    GROUP BY
      category,
      app
    ORDER BY
      num DESC
    LIMIT 20
  ) AS top ON (tech.category = top.category AND tech.app = top.app)
  WHERE
    REGEXP_CONTAINS(info, r'\d+\.\d+')
    AND REGEXP_CONTAINS(_TABLE_SUFFIX, r'^20(20|19).*')
  GROUP BY
    tech.category,
    tech.app,
    info,
    _TABLE_SUFFIX)
WHERE
  pct > 0.01
ORDER BY
  client,
  category,
  app,
  month,
  pct DESC
