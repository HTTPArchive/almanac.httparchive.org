#standardSQL
# Distribution of the different version of the top 20 technologies used on the web.

SELECT
  category,
  app,
  info,
  month,
  client,
  freq,
  pct
FROM (
  SELECT
    info,
    tech.category_lower AS category,
    tech.app_lower AS app,
    month,
    client,
    COUNT(0) AS freq,
    COUNT(0) / SUM(COUNT(0)) OVER (PARTITION BY client, month, tech.category_lower, tech.app_lower) AS pct
  FROM (
    SELECT
      info,
      TRIM(LOWER(category)) AS category_lower,
      TRIM(LOWER(app)) AS app_lower,
      LEFT(_TABLE_SUFFIX, 10) AS month,
      IF(ENDS_WITH(_TABLE_SUFFIX, '_desktop'), 'desktop', 'mobile') AS client
    FROM
      `httparchive.technologies.*`
    WHERE
      REGEXP_CONTAINS(info, r'\d+\.\d+') AND
      _TABLE_SUFFIX >= '2020'
  ) AS tech
  INNER JOIN (
    SELECT
      TRIM(LOWER(category)) AS category_lower,
      TRIM(LOWER(app)) AS app_lower,
      COUNT(0) AS num
    FROM
      `httparchive.technologies.*`
    WHERE
      _TABLE_SUFFIX >= '2020'
    GROUP BY
      category_lower,
      app_lower
    ORDER BY
      num DESC
    LIMIT 20
  ) AS top ON (tech.category_lower = top.category_lower AND tech.app_lower = top.app_lower)
  GROUP BY
    tech.category_lower,
    tech.app_lower,
    month,
    info,
    client
)
WHERE
  pct > 0.01
ORDER BY
  client,
  category,
  app,
  month,
  pct DESC
