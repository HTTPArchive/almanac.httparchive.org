#standardSQL
# 01_09: Changes in top JS libraries
SELECT
  app,
  client,
  freq_2018,
  ROUND(pct_2018 * 100, 2) AS pct_2018,
  freq_2019,
  ROUND(pct_2019 * 100, 2) AS pct_2019,
  ROUND((pct_2019 - pct_2018) * 100, 2) AS pct_pt_change,
  IF(pct_2018 > 0, ROUND((pct_2019 - pct_2018) * 100 / pct_2018, 2), NULL) AS pct_change
FROM (
  SELECT
    app,
    _TABLE_SUFFIX AS client,
    COUNT(DISTINCT url) AS freq_2018,
    COUNT(DISTINCT url) / total AS pct_2018
  FROM (SELECT _TABLE_SUFFIX, COUNT(url) AS total FROM `httparchive.summary_pages.2018_07_01_*` GROUP BY _TABLE_SUFFIX)
  JOIN
    `httparchive.technologies.2018_07_01_*`
  USING (_TABLE_SUFFIX)
  GROUP BY
    app,
    client,
    total
)
JOIN (
  SELECT
    app,
    _TABLE_SUFFIX AS client,
    COUNT(DISTINCT url) AS freq_2019,
    COUNT(DISTINCT url) / total AS pct_2019
  FROM (SELECT _TABLE_SUFFIX, COUNT(url) AS total FROM `httparchive.summary_pages.2019_07_01_*` GROUP BY _TABLE_SUFFIX)
  JOIN
    `httparchive.technologies.2019_07_01_*`
  USING (_TABLE_SUFFIX)
  WHERE
    category = 'JavaScript Libraries'
  GROUP BY
    app,
    client,
    total
)
USING (app, client)
WHERE
  freq_2019 > 10
ORDER BY
  freq_2019 DESC
