WITH websites_using_cname_tracking as (SELECT DISTINCT NET.REG_DOMAIN(d) as d FROM `bamboo-chariot-267911.cname_analysis.results_tracking_2021_08_01`, unnest(domains) as d),
 suffixes as (SELECT NET.PUBLIC_SUFFIX(d) as suffix FROM websites_using_cname_tracking)
SELECT suffix, COUNT(suffix) as nb_websites_with_suffix
FROM suffixes
GROUP BY suffix
ORDER BY nb_websites_with_suffix DESC
