-- Privacy Sandbox Attestation and Related Websites JSON status (i.e., advertisers) registered, registering third-parties, and registering publishers (at site level)

WITH wellknown AS (
  SELECT
    client,
    NET.HOST(page) AS host,
    CASE
      WHEN rank <= 1000 THEN '1000'
      WHEN rank <= 10000 THEN '10000'
      WHEN rank <= 100000 THEN '100000'
      WHEN rank <= 1000000 THEN '1000000'
      WHEN rank <= 10000000 THEN '10000000'
      ELSE 'Other'
    END AS rank_group,
    SAFE.BOOL(custom_metrics.other.`well-known`.`/.well-known/related-website-set.json`.found) AS rws,
    SAFE.BOOL(custom_metrics.other.`well-known`.`/.well-known/privacy-sandbox-attestations.json`.found) AS attestation
  FROM
    `httparchive.crawl.pages`
  WHERE
    date = '2025-07-01' AND
    is_root_page = TRUE
)

SELECT
  client,
  rank_group,
  SUM(CASE WHEN rws THEN 1 ELSE 0 END) AS related_websites_set,
  SUM(CASE WHEN attestation THEN 1 ELSE 0 END) AS privacy_sandbox_attestation
FROM
  wellknown
WHERE
  rws OR attestation
GROUP BY client, rank_group
ORDER BY
  client,
  CASE rank_group
    WHEN '1000' THEN 1
    WHEN '10000' THEN 2
    WHEN '100000' THEN 3
    WHEN '1000000' THEN 4
    WHEN '10000000' THEN 5
    ELSE 6
  END;
