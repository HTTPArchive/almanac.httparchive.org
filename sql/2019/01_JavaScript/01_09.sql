#standardSQL
# 01_09: Changes in top JS libraries
SELECT
  app,
  freq_2018,
  ROUND(pct_2018 * 100, 2) AS pct_2018,
  freq_2019,
  ROUND(pct_2019 * 100, 2) AS pct_2019,
  ROUND((pct_2019 - pct_2018) * 100, 2) AS pct_pt_change,
  IF(pct_2018 > 0, ROUND((pct_2019 - pct_2018) * 100 / pct_2018, 2), NULL) AS pct_change
FROM (
  SELECT
    app,
    COUNT(DISTINCT url) AS freq_2018,
    COUNT(DISTINCT url) / total AS pct_2018
  FROM
    (SELECT COUNT(DISTINCT url) AS total FROM `httparchive.summary_pages.2018_07_01_*`),
    `httparchive.technologies.2018_07_01_*`
  GROUP BY
    app,
    total)
JOIN (
  SELECT
    app,
    COUNT(DISTINCT url) AS freq_2019,
    COUNT(DISTINCT url) / total AS pct_2019
  FROM
    (SELECT COUNT(DISTINCT url) AS total FROM `httparchive.summary_pages.2019_07_01_*`),
    `httparchive.technologies.2019_07_01_*`
  WHERE
    category = 'JavaScript Libraries'
  GROUP BY
    app,
    total)
USING (app)
WHERE
  freq_2019 > 10
ORDER BY
  freq_2019 DESC