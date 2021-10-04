#standardSQL
# Most popular hosts users preload from
# capped to one hit per url to avoid having the results skewed by websites which preload many resources from the same host


CREATE TEMPORARY FUNCTION getResourceHintsHrefs(payload STRING, hint STRING)
RETURNS ARRAY<STRING>
LANGUAGE js AS '''
try {
  var $ = JSON.parse(payload);
  var almanac = JSON.parse($._almanac);
  return almanac['link-nodes'].nodes.filter(link => link.rel.toLowerCase() == hint).map(n => n.href);
} catch (e) {  
  return [];
}
''' ;

SELECT
  client,
  host,
  COUNT(0) AS freq,
  COUNT(0) / SUM(COUNT(0)) OVER() AS pct
FROM (
    SELECT
      client,
      url,
      host
    FROM (
        SELECT
          client,
          url,
          NET.HOST(href) AS host
        FROM (
          SELECT
            _TABLE_SUFFIX AS client,
            url,
            getResourceHintsHrefs(payload, "preload") AS value
          FROM
            `httparchive.pages.2021_07_01_*`
        )
        CROSS JOIN UNNEST(value) AS href
        WHERE
          ARRAY_LENGTH(value) > 0
    )
    GROUP BY
      client,
      url,
      host
)
GROUP BY
  client,
  host
HAVING
  freq > 1
ORDER BY
  client,
  freq DESC
LIMIT 100
