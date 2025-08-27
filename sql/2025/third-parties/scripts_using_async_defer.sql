#standardSQL
# 3P scripts using async or defer
# (capped to 1 hit per domain per page)
CREATE TEMPORARY FUNCTION getScripts(str STRING)
RETURNS ARRAY<STRUCT<src STRING, isAsync BOOL, isDefer BOOL>>
LANGUAGE js AS '''
  try {
    var almanac = JSON.parse(str);

    if (Array.isArray(almanac) || typeof almanac != "object") {
      return result;
    }

    if (almanac.scripts && almanac.scripts.nodes) {
      return almanac.scripts.nodes.map((n) => ({
        src: n.src,
        isAsync: n.hasOwnProperty("async"),
        isDefer: n.hasOwnProperty("defer"),
      }));
    }

    return [];
  } catch (e) {
    return [];
  }
''';

WITH third_party_domains AS (
  SELECT DISTINCT
    NET.HOST(domain) AS domain
  FROM
    `httparchive.almanac.third_parties`
),

base AS (
  SELECT
    client,
    page,
    third_party_domains.domain AS domain,
    COUNTIF(isAsync) AS async_count,
    COUNTIF(isDefer) AS defer_count
  FROM
    (
      SELECT
        _TABLE_SUFFIX AS client,
        NET.HOST(data.src) AS domain,
        data.isAsync AS isAsync,
        data.isDefer AS isDefer,
        pages.url AS page
      FROM
        `httparchive.pages.2025_07_01_*` AS pages,
        UNNEST(getScripts(JSON_EXTRACT_SCALAR(payload, '$._almanac'))) AS data
    ) AS potential_third_parties
  INNER JOIN
    third_party_domains
  ON
    potential_third_parties.domain = third_party_domains.domain
  GROUP BY
    client,
    page,
    domain
)

SELECT
  base.client AS client,
  COUNTIF(async_count > 0) AS freq_async,
  COUNTIF(defer_count > 0) AS freq_defer,
  COUNT(0) AS total,
  COUNTIF(async_count > 0) / COUNT(0) AS pct_async,
  COUNTIF(defer_count > 0) / COUNT(0) AS pct_defer
FROM
  base
GROUP BY
  client
ORDER BY
  client
