CREATE TEMPORARY FUNCTION getResourceHints(payload STRING)
RETURNS ARRAY < STRUCT < name STRING, href STRING >>
    LANGUAGE js AS '''
var hints = new Set(['preload', 'prefetch', 'preconnect', 'prerender', 'dns-prefetch']);
try {
    var $ = JSON.parse(payload);
    var almanac = JSON.parse($._almanac);
    return almanac['link-nodes'].nodes.reduce((results, link) => {
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
''';
SELECT
  client,
  name,
  type,
  COUNT(DISTINCT page) AS freq_hints,
  total_page,
  COUNT(DISTINCT page) / total_page AS pct_hints,
  COUNT(DISTINCT IF(fast_fcp >= 0.75, page, NULL)) / COUNT(DISTINCT page) AS pct_good_fcp,
  COUNT(DISTINCT IF(NOT(slow_fcp >= 0.25) AND NOT(fast_fcp >= 0.75), page, null))  / COUNT(DISTINCT page) AS pct_ni_fcp,
  COUNT(DISTINCT IF(slow_fcp >= 0.25, page, null)) / COUNT(DISTINCT page) AS pct_poor_fcp,
FROM (
  SELECT DISTINCT
    _TABLE_SUFFIX AS client,
    url AS page,
    COUNT(DISTINCT url) OVER (PARTITION BY _TABLE_SUFFIX) AS total_page,
    hint.name
  FROM
    `httparchive.pages.2020_08_01_*`
  LEFT JOIN
    UNNEST(getResourceHints(payload)) AS hint)
JOIN (
  SELECT DISTINCT
    IF(device='desktop','desktop', IF(device='phone','mobile',null)) AS client,
    CONCAT(origin, '/') AS page,
    fast_fcp,
    slow_fcp
  FROM
    `chrome-ux-report.materialized.device_summary`
  WHERE
    yyyymm = 202008)
USING
  (client, page)
LEFT JOIN (
  SELECT
    client,
    page,
    type
  FROM
    `httparchive.almanac.requests`
   where date='2020-08-01')
USING
  (client, page)  
GROUP BY
  client,
  name,
  type,
  total_page
ORDER BY
  pct_hints DESC