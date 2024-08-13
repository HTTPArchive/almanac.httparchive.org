-- attested-domains-in-top-1M-using-privacy-sandbox.sql
-- Contributed by: @yohhaan
-- Urls that may have a `/.well-known/related-website-set.json` for Privacy Sandbox Related Website Set Proposal and 
-- Urls that may have a `/.well-known/privacy-sandbox-attestations.json` for Privacy Sandbox APIs Attestation file
-- Note: we are only extracting a potential list of origins that may have the file to feed to another crawler (https://github.com/privacysandstorm/well-known-crawler) that will actually check if file is valid by parsing it
-- Test query on `httparchive.sample_data.pages_1k` and `TABLESAMPLE SYSTEM (1.0 PERCENT)` with latest date of crawl
-- Final query on `httparchive.all.pages`


WITH wellknown AS (
  SELECT
    NET.HOST(page) as host,
    CAST(JSON_VALUE(custom_metrics, '$.well-known."/.well-known/related-website-set.json".found') AS BOOL) AS rws,
    CAST(JSON_VALUE(custom_metrics, '$.well-known."/.well-known/privacy-sandbox-attestations.json".found') AS BOOL) AS attestation
  FROM
    `httparchive.all.pages` 
  WHERE
    date = '2024-06-01' AND
    client = 'desktop' AND
    is_root_page = TRUE AND
    rank <= 1000000
)

SELECT DISTINCT
  host,
  CASE WHEN rws THEN 1 ELSE 0 END AS related_websites_set,
  CASE WHEN attestation THEN 1 ELSE 0 END AS privacy_sandbox_attestation
FROM
  wellknown
WHERE 
  rws OR attestation;