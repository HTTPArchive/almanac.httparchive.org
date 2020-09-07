#standardSQL
#font_resource_hints_with_fcp(??NoResult)
CREATE TEMPORARY FUNCTION getResourceHints(payload STRING)
RETURNS ARRAY < STRUCT < name STRING, href STRING >>
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
''';

SELECT
  _TABLE_SUFFIX AS client,
  name,
  COUNT(DISTINCT url) AS freq_hints,
  total_page,
  ROUND(COUNT(DISTINCT url) * 100 / total_page, 2) AS pct_hints,
  COUNTIF(fast_fcp>=0.75)*100/COUNT(0) AS pct_fast_fcp_hints,
  COUNTIF(NOT(slow_fcp >=0.25)
    AND NOT(fast_fcp>=0.75)) *100/COUNT(0) AS pct_avg_fcp_hints,
  COUNTIF(slow_fcp>=0.25)*100/COUNT(0) AS pct_slow_fcp_hints,
FROM (
  SELECT
    _TABLE_SUFFIX,
    url,
    hint.name,
    hint.href AS hint_url
  FROM
    `httparchive.pages.2020_08_01_*`,
    UNNEST(getResourceHints(payload)) AS hint)
LEFT JOIN (
  SELECT
    _TABLE_SUFFIX AS client,
    url,
    type
  FROM
    `httparchive.summary_requests.2020_08_01_*`
  WHERE
    type='font')
USING
  (url)
JOIN (
  SELECT
    origin,
    fast_fcp,
    slow_fcp,
  FROM
    `chrome-ux-report.materialized.metrics_summary`
  WHERE
    yyyymm=202007)
ON
  CONCAT(origin, '/')=url
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
WHERE
  NET.HOST(hint_url)=NET.HOST(url)
  AND SUBSTR(hint_url,0,5)=SUBSTR(url,0,5)
GROUP BY
  client,
  name,
  url,
  total_page
ORDER BY
  client,
  name,
  freq_hints DESC