WITH websites_using_cname_tracking AS (
  SELECT DISTINCT
    NET.REG_DOMAIN(domain) AS domain,
    NET.PUBLIC_SUFFIX(NET.REG_DOMAIN(domain)) AS suffix,
    tracker
  FROM
    `httparchive.almanac.cname_tracking`,
    UNNEST(SPLIT(SUBSTRING(domains, 2, LENGTH(domains) - 2))) AS domain
),

totals AS (
  SELECT
    _TABLE_SUFFIX AS _TABLE_SUFFIX,
    count(0) AS total_pages
  FROM
    `httparchive.summary_pages.2021_07_01_*`
  GROUP BY
    _TABLE_SUFFIX
)

SELECT
  _TABLE_SUFFIX AS client,
  suffix,
  COUNT(0) AS num_pages,
  total_pages,
  COUNT(0) / total_pages AS pct_pages
FROM
  `httparchive.summary_pages.2021_07_01_*`
JOIN
  totals
USING (_TABLE_SUFFIX)
JOIN
  websites_using_cname_tracking
ON domain = NET.REG_DOMAIN(urlShort)
GROUP BY
  client,
  total_pages,
  suffix
ORDER BY
  pct_pages DESC,
  client
