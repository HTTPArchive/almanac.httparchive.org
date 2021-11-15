SELECT
    rank,
    COUNT(d)
FROM(
    SELECT
        d,
        MIN(rank) AS rank FROM (
            WITH websites_using_cname_tracking AS ( DISTINCT
                SELECT net.REG_DOMAIN(d) AS dFROM `bamboo-chariot-267911.cname_analysis.results_tracking_2021_08_01`, unnest(domains) as d
            )

            SELECT
                d,
                ARRAY_AGG(rank) AS ranks
FROM `httparchive.summary_pages.2021_08_01_desktop` JOIN websites_using_cname_tracking on d = NET.REG_DOMAIN(urlShort)
            GROUP BY d),
        UNNEST(ranks)
    GROUP BY d)
GROUP BY rank
ORDER BY rank ASC
