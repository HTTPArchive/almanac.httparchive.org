#standardSQL
# Section: Malpractices on the web
# Question: Which cryptominers have the largest market share?
SELECT
  client,
  t.technology,
  SUM(COUNT(0)) OVER (PARTITION BY client) AS total_cryptominers,
  COUNT(0) AS freq,
  COUNT(0) / SUM(COUNT(0)) OVER (PARTITION BY client) AS pct
FROM
  `httparchive.all.pages`,
  UNNEST(technologies) AS t,
  UNNEST(t.categories) AS category
WHERE
  date = '2025-07-01' AND
  category = 'Cryptominers' AND
  is_root_page
GROUP BY
  client,
  t.technology
ORDER BY
  client,
  pct DESC
