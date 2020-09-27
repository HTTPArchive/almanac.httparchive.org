#standardSQL
#font_resource_hints_with_fcp(??NoResult)
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
    return [null];
}
''';
SELECT
  client,
  name,
  COUNT(DISTINCT page) AS freq_hints,
  total_page,
  COUNT(DISTINCT page)*100/total_page AS pct_hints,
  COUNTIF(fast_fcp>=0.75)*100/COUNT(0) AS pct_good_fcp_hints,
  COUNTIF(NOT(slow_fcp>=0.25)
    AND NOT(fast_fcp>=0.75))*100/COUNT(0) AS pct_ni_fcp_hints,
  COUNTIF(slow_fcp>=0.25)*100/COUNT(0) AS pct_poor_fcp_hints,
FROM (
  SELECT
    _TABLE_SUFFIX AS client,
    url AS page,
    hint.name
  FROM
    `httparchive.pages.2020_08_01_*`
    LEFT JOIN UNNEST(getResourceHints(payload)) AS hint)
LEFT JOIN (
  SELECT
    _TABLE_SUFFIX AS client,
    url AS page
  FROM
    `httparchive.summary_requests.2020_08_01_*`
  WHERE
    type='font')
USING
  (client, page)
JOIN (
  SELECT DISTINCT
    origin, device,
    fast_fcp,
    slow_fcp,
  FROM
    `chrome-ux-report.materialized.device_summary`
  WHERE
    date='2020-08-01')
ON
  CONCAT(origin, '/')=page AND
  IF(device='desktop','desktop','mobile')=client
JOIN (
  SELECT
    _TABLE_SUFFIX AS client,
    COUNT(0) AS total_page
  FROM
    `httparchive.summary_pages.2020_08_01_*`
  GROUP BY
    _TABLE_SUFFIX)
USING
  (client)
GROUP BY
  client,
  name,
  total_page
ORDER BY
  client,
  name,
  freq_hints DESC