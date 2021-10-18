#standardSQL
# A11Y technology usage
SELECT
  client,
  total_sites,
  sites_with_a11y_tech,
  sites_with_a11y_tech / total_sites AS perc_sites_with_a11y_tech
FROM (
  SELECT
    _TABLE_SUFFIX AS client,
    COUNT(DISTINCT url) AS sites_with_a11y_tech
  FROM
    `httparchive.technologies.2021_07_01_*`
  WHERE
    category = "Accessibility"
  GROUP BY
    client
)
JOIN (
  SELECT
    _TABLE_SUFFIX AS client,
    COUNT(0) AS total_sites
  FROM
    `httparchive.summary_pages.2021_07_01_*`
  GROUP BY
    client
)
USING (client)
