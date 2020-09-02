#standardSQL
#font_resource_hints_with_fcp
CREATE TEMPORARY FUNCTION getResourceHints(payload STRING)
RETURNS ARRAY<STRUCT<name STRING, href STRING>>
LANGUAGE js AS '''
var hints = new Set(['preload', 'prefetch', 'preconnect', 'prerender', 'dns-prefetch']);
try {
var $ = JSON.parse(payload);
var almanac = JSON.parse($._almanac);
return almanac['link-nodes'].reduce((results, link) => {
var hint = link.rel.toLowerCase();
if (!hints.has(hint)) {
return results;
}
results.push({
name: hint,
href: link.href
});
return results;
}, []);
} catch (e) {
return [];
}
'';

SELECT
 _TABLE_SUFFIX AS client,
 name,
 COUNT(DISTINCT page) AS freq_hints,
 COUNT(0) AS total_hints,
 ROUND(COUNT(DISTINCT page) * 100 / COUNT(0), 2) AS pct_hints,
 COUNTIF(fast_fcp>=0.75)*100/count(0) as pct_fast_fcp_hints,
 COUNTIF(NOT(slow_fcp >=0.25) AND NOT(fast_fcp>=0.75)) *100/count(0) as pct_avg_fcp_hints,
 COUNTIF(slow_fcp>=0.25)*100/count(0) as pct_slow_fcp_hints,
FROM (
 SELECT _TABLE_SUFFIX, url AS page, hint.name, hint.href AS url
 FROM `httparchive.pages.2020_08_01_*`, UNNEST(getResourceHints(payload)) AS hint)
LEFT JOIN (
 SELECT client AS _TABLE_SUFFIX, page, url, type
FROM 
  `httparchive.almanac.summary_requests` where type='font')
USING 
 (_TABLE_SUFFIX, page, url)
JOIN 
 (select origin, fast_fcp, slow_fcp,
FROM 
 `chrome-ux-report.materialized.device_summary` where yyyymm=202007)
ON  
 concat(origin, '/')=page
GROUP BY 
 client, name
ORDER BY 
 client, name DESC
