# Most common CNAME domains

CREATE TEMP FUNCTION convert_cname_json(json_str STRING)
RETURNS ARRAY<STRUCT<origin STRING, cname STRING>>
LANGUAGE js AS """
  const obj = JSON.parse(json_str);
  const result = [];
  for (const key in obj) {
    result.push({
      origin: key,
      cname: obj[key]
    });
  }
  return result;
""";

WITH whotracksme AS (
  SELECT DISTINCT
    domain
  FROM `httparchive.almanac.whotracksme`
  WHERE date = '2024-06-01' AND
    category IN ('advertising', 'site_analytics')
), cnames AS (
  SELECT
    client,
    NET.REG_DOMAIN(cnames.cname) AS cname_domain,
    COUNT(DISTINCT NET.REG_DOMAIN(cnames.origin)) AS number_of_request_domains,
    COUNT(DISTINCT page) AS number_of_pages
  --ARRAY_AGG(DISTINCT cnames.origin LIMIT 2) AS request_domain_examples,
  --ARRAY_AGG(DISTINCT page LIMIT 2) AS page_examples,
  FROM `httparchive.all.pages`,
    UNNEST(convert_cname_json(JSON_QUERY(custom_metrics, '$.privacy.request_hostnames_with_cname'))) AS cnames
  WHERE date = '2024-06-01' AND
    is_root_page = TRUE
  GROUP BY
    client,
    cname_domain
)

SELECT
  client,
  cnames.cname_domain AS cname,
  number_of_request_domains,
  number_of_pages
FROM cnames
INNER JOIN whotracksme
ON cnames.cname_domain = whotracksme.domain
ORDER BY number_of_request_domains DESC
