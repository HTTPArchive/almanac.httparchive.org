#standardSQL
# Most popular domains users dns-prefetch from

CREATE TEMPORARY FUNCTION getResourceHints(payload STRING)
RETURNS STRING
LANGUAGE js AS '''
var hint = 'dns-prefetch';
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
''';

SELECT 
    client,
    domain,
    COUNT(0) as freq,
    SUM(COUNT(0)) OVER() as total,
FROM (
    SELECT
    client,
    REGEXP_EXTRACT(href, r'^https?\:\/\/(.+?)\/') AS domain,
    FROM (
        SELECT
            client,
            getHrefs(hints) as value
        FROM (
            SELECT
                _TABLE_SUFFIX AS client,
                getResourceHints(payload) AS hints
            FROM
                `httparchive.pages.2021_07_01*`
        )    
    )
    CROSS JOIN UNNEST(value) AS href
    WHERE
        ARRAY_LENGTH(value) > 0
)
WHERE
    domain IS NOT NULL
GROUP BY
    client,
    domain
HAVING
    freq > 1
ORDER BY
    client,
    freq DESC
