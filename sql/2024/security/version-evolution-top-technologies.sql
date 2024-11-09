#standardSQL
# Section: Drivers of security mechanims - Technology stack
# Question: Distribution of the different version of the top 20 technologies used on the web.
SELECT
  category,
  technology,
  info,
  date,
  client,
  freq,
  pct
FROM (
  SELECT
    info,
    tech.category_lower AS category,
    tech.technology_lower AS technology,
    date,
    client,
    COUNT(0) AS freq,
    COUNT(0) / SUM(COUNT(0)) OVER (PARTITION BY client, date, tech.category_lower, tech.technology_lower) AS pct
  FROM (
    SELECT
      info,
      TRIM(LOWER(category)) AS category_lower,
      TRIM(LOWER(t.technology)) AS technology_lower,
      date,
      client
    FROM
      `httparchive.all.pages`,
      UNNEST(technologies) AS t,
      UNNEST(t.categories) AS category,
      UNNEST(t.info) AS info
    WHERE
      DATE >= '2022-06-01' AND
      is_root_page AND
      REGEXP_CONTAINS(info, r'\d+\.\d+')
  ) AS tech
  INNER JOIN (
    SELECT
      TRIM(LOWER(category)) AS category_lower,
      TRIM(LOWER(technology)) AS technology_lower,
      COUNT(0) AS num
    FROM
      `httparchive.all.pages`,
      UNNEST(technologies) AS t,
      UNNEST(t.categories) AS category,
      UNNEST(t.info) AS info
    WHERE
      DATE >= '2022-06-01' AND
      is_root_page
    GROUP BY
      category_lower,
      technology_lower
    ORDER BY
      num DESC
    LIMIT 20
  ) AS top ON (tech.category_lower = top.category_lower AND tech.technology_lower = top.technology_lower)
  GROUP BY
    tech.category_lower,
    tech.technology_lower,
    date,
    info,
    client)
WHERE
  pct > 0.01
ORDER BY
  client,
  category,
  technology,
  date,
  pct DESC
