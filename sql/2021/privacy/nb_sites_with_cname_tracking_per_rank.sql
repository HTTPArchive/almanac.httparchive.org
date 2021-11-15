SELECT rank, COUNT(d)
FROM(
SELECT d,MIN(rank) as rank FROM (
WITH websites_using_cname_tracking as (SELECT DISTINCT NET.REG_DOMAIN(d) as d FROM `bamboo-chariot-267911.cname_analysis.results_tracking_2021_08_01`, unnest(domains) as d)
SELECT  d, ARRAY_AGG(rank) as ranks
FROM `httparchive.summary_pages.2021_08_01_desktop` JOIN websites_using_cname_tracking on d = NET.REG_DOMAIN(urlShort)
GROUP by d),
unnest(ranks) as rank
GROUP by d)
GROUP BY rank
ORDER BY rank ASC
