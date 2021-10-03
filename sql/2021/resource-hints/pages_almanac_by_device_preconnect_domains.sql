#standardSQL
# Most popular domains users preconnect to

# helper to create percent fields
CREATE TEMP FUNCTION AS_PERCENT (freq FLOAT64, total FLOAT64) RETURNS FLOAT64 AS (
  ROUND(SAFE_DIVIDE(freq, total), 4)
);

CREATE TEMPORARY FUNCTION getResourceHints(payload STRING, hint STRING)
RETURNS STRING
LANGUAGE js AS '''
try {
  var $ = JSON.parse(payload);
  var almanac = JSON.parse($._almanac);
  return JSON.stringify(almanac['link-nodes'].nodes.filter(link => link.rel.toLowerCase() == hint));
} catch (e) {  
  return "";
}
''' ;

CREATE TEMPORARY FUNCTION getHrefs(payload STRING)
RETURNS ARRAY<STRING>
LANGUAGE js AS '''
try {
    var $ = JSON.parse(payload);
    return $.map(n => n.href);
} catch (e) {
    return [];
}
''' ;

SELECT
  client,
  domain,
  COUNT(0) AS freq,
  AS_PERCENT(COUNT(0), SUM(COUNT(0)) OVER()) AS pct
FROM (
    SELECT
      client,
      REGEXP_EXTRACT(href, r'\/\/(.+?)$') AS domain
    FROM (
        SELECT
          client,
          getHrefs(hints) AS value
        FROM (
            SELECT
              _TABLE_SUFFIX AS client,
              getResourceHints(payload, "preconnect") AS hints
            FROM
              `httparchive.pages.2021_07_01_*`
        )
    )
    CROSS JOIN UNNEST(value) AS href
    WHERE
      ARRAY_LENGTH(value) > 0
)
GROUP BY
  client,
  domain
HAVING
  freq > 1
ORDER BY
  client,
  freq DESC
LIMIT 100
