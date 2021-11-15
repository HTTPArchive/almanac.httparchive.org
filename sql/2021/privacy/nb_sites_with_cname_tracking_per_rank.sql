SELECT
  rank,
  COUNT(d) AS nb_sites
FROM (
  SELECT
    d,
    MIN(rank) AS rank
  FROM (
    WITH websites_using_cname_tracking AS (
      SELECT DISTINCT NET.REG_DOMAIN(d) AS d
      FROM
        `bamboo-chariot-267911.cname_analysis.results_tracking_2021_08_01`,
        UNNEST(domains) AS d
    )

    SELECT
      d,
      ARRAY_AGG(rank) AS ranks
    FROM
      `httparchive.summary_pages.2021_08_01_desktop`
    JOIN
      websites_using_cname_tracking
    ON d = NET.REG_DOMAIN(urlShort)
    GROUP BY
      d
    ),
    UNNEST(ranks) AS rank
  GROUP BY
    d
)
GROUP BY
  rank
ORDER BY
  rank
