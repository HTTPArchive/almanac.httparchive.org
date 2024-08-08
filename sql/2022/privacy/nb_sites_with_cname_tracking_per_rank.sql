WITH websites_using_cname_tracking AS (
  SELECT DISTINCT
    NET.REG_DOMAIN(domain) AS domain
  FROM
    `httparchive.almanac.cname_tracking`,
    UNNEST(SPLIT(SUBSTRING(domains, 2, LENGTH(domains) - 2))) AS domain
),

totals AS (
  SELECT
    _TABLE_SUFFIX,
    rank_grouping,
    count(0) AS total_pages
  FROM
    `httparchive.summary_pages.2022_06_01_*`,
    UNNEST([1000, 10000, 100000, 1000000, 10000000]) AS rank_grouping
  WHERE
    rank <= rank_grouping
  GROUP BY
    _TABLE_SUFFIX,
    rank_grouping
)

SELECT
  _TABLE_SUFFIX AS client,
  rank_grouping,
  CASE rank_grouping
    WHEN 10000000 THEN 'all'
    ELSE TRIM(CAST(rank_grouping AS STRING FORMAT '99,999,999'))
  END AS rank_grouping_text,
  count(0) AS num_cname_pages,
  total_pages,
  count(0) / total_pages AS pct_pages
FROM
  `httparchive.summary_pages.2022_06_01_*`,
  UNNEST([1000, 10000, 100000, 1000000, 10000000]) AS rank_grouping
JOIN
  totals
USING (_TABLE_SUFFIX, rank_grouping)
JOIN
  websites_using_cname_tracking
ON domain = NET.REG_DOMAIN(urlShort)
WHERE
  rank <= rank_grouping
GROUP BY
  client,
  total_pages,
  rank_grouping
ORDER BY
  rank_grouping,
  client
