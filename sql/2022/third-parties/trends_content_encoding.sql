#standardSQL
#party of content encoding

WITH third_party_domains AS (
  SELECT DISTINCT
    NET.HOST(domain) AS domain
  FROM
    `httparchive.almanac.third_parties`
),

base AS (
  SELECT
    "2022" AS year,
    client,
    domain,
    resp_content_encoding
  FROM (
    SELECT
      "2022" AS year,
      client,
      third_party_domains.domain AS domain,
      resp_content_encoding
    FROM (
      SELECT
        client,
        url AS page,
        NET.HOST(url) AS domain,
        resp_content_encoding,
      FROM
        `httparchive.almanac.requests`
      WHERE
        date = '2022-06-01'
    ) AS potential_third_parties
    LEFT OUTER JOIN
      third_party_domains
    ON
      potential_third_parties.domain = third_party_domains.domain
    GROUP BY
      client,
      page,
      domain,
      resp_content_encoding
  )
  UNION ALL
  SELECT
    "2021" AS year,
    client,
    domain,
    resp_content_encoding
  FROM (
    SELECT
      "2021" AS year,
      client,
      third_party_domains.domain AS domain,
      resp_content_encoding
    FROM (
      SELECT
        client,
        url AS page,
        NET.HOST(url) AS domain,
        resp_content_encoding,
      FROM
        `httparchive.almanac.requests`
      WHERE
        date = '2021-07-01'
    ) AS potential_third_parties
    LEFT OUTER JOIN
      third_party_domains
    ON
      potential_third_parties.domain = third_party_domains.domain
    GROUP BY
      client,
      page,
      domain,
      resp_content_encoding
  )
  UNION ALL
  SELECT
    "2020" AS year,
    client,
    domain,
    resp_content_encoding
  FROM (
    SELECT
      "2020" AS year,
      client,
      third_party_domains.domain AS domain,
      resp_content_encoding
    FROM (
      SELECT
        client,
        url AS page,
        NET.HOST(url) AS domain,
        resp_content_encoding,
      FROM
        `httparchive.almanac.requests`
      WHERE
        date = '2020-08-01'
    ) AS potential_third_parties
    LEFT OUTER JOIN
      third_party_domains
    ON
      potential_third_parties.domain = third_party_domains.domain
    GROUP BY
      client,
      page,
      domain,
      resp_content_encoding
  )
)

SELECT
  year,
  client,
  resp_content_encoding,
  COUNTIF(domain IS NOT NULL) AS third_party_requests,
  COUNTIF(domain IS NULL) AS first_party_requests,
  SUM(COUNTIF(domain IS NOT NULL)) OVER (PARTITION BY year, client) AS total_third_party_requests,
  SUM(COUNTIF(domain IS NULL)) OVER (PARTITION BY year, client) AS total_first_party_requests,
  COUNTIF(domain IS NOT NULL) / SUM(COUNTIF(domain IS NOT NULL)) OVER (PARTITION BY year, client) AS pct_third_party_requests,
  COUNTIF(domain IS NULL) / SUM(COUNTIF(domain IS NULL)) OVER (PARTITION BY year, client) AS pct_first_party_requests
FROM
  base
GROUP BY
  year,
  client,
  resp_content_encoding
ORDER BY  
  year,
  client,
  third_party_requests DESC
