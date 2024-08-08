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
    category_lower AS category,
    app_lower AS app,
    month,
    client,
    COUNT(0) AS freq,
    COUNT(0) / SUM(COUNT(0)) OVER (PARTITION BY client, month, category_lower, app_lower) AS pct
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
      REGEXP_CONTAINS(_TABLE_SUFFIX, r'^20(20|19).*')
  )
  INNER JOIN (
    SELECT
      TRIM(LOWER(category)) AS category_lower,
      TRIM(LOWER(app)) AS app_lower,
      COUNT(0) AS num
    FROM
      `httparchive.technologies.*`
    WHERE
      REGEXP_CONTAINS(_TABLE_SUFFIX, r'^20(20|19).*')
    GROUP BY
      category_lower,
      app_lower
    ORDER BY
      num DESC
    LIMIT 20
  )
  USING (category_lower, app_lower)
  GROUP BY
    category_lower,
    app_lower,
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
