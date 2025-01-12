#standardSQL
# Percentage of requests for script files which are preceded by a preconnect

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
''';

WITH resource_hints AS (
  SELECT
    client,
    page,
    host
  FROM (
    SELECT
      client,
      page,
      NET.HOST(href) AS host
    FROM
      `httparchive.all.pages`,
      UNNEST(getResourceHintsHrefs(payload, 'preconnect')) AS href
    WHERE
      date = '2024-06-01'
  )
  GROUP BY
    client,
    page,
    host
),

third_party_domains AS (
  SELECT DISTINCT
    NET.HOST(domain) AS host
  FROM
    `httparchive.almanac.third_parties`
),

requests AS (
  SELECT
    client,
    page,
    NET.HOST(url) AS host
  FROM
    `httparchive.all.requests`
  INNER JOIN
    third_party_domains
  ON
    (third_party_domains.host = NET.HOST(url))
  WHERE
    date = '2024-06-01' AND
    type = 'script'
  GROUP BY
    client,
    page,
    host
)

SELECT
  client,
  host,
  freq,
  total,
  pct
FROM (
  SELECT
    client,
    host,
    COUNTIF(resource_hints.host IS NOT NULL) AS freq,
    SUM(COUNT(0)) OVER (PARTITION BY client, host) AS total,
    COUNTIF(resource_hints.host IS NOT NULL) / SUM(COUNT(0)) OVER (PARTITION BY client, host) AS pct,
    RANK() OVER (PARTITION BY client ORDER BY COUNTIF(resource_hints.host IS NOT NULL) DESC) AS resource_hint_rank
  FROM
    requests
  LEFT OUTER JOIN
    resource_hints
  USING (client, page, host)
  GROUP BY
    client,
    host
)
WHERE
  resource_hint_rank < 100
ORDER BY
  client,
  total DESC
