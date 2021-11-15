WITH websites_using_cname_tracking AS (
    SELECT 
        DISTINCT net.REG_DOMAIN(d) AS d
    FROM `bamboo-chariot-267911.cname_analysis.results_tracking_2021_08_01`, unnest(domains) as d
),

suffixes AS (
    SELECT net.PUBLIC_SUFFIX(d) AS suffix FROM websites_using_cname_tracking
)

SELECT
    suffix,
    COUNT(suffix) AS nb_websites_with_suffix
FROM suffixes
GROUP BY suffix
ORDER BY nb_websites_with_suffix DESC
