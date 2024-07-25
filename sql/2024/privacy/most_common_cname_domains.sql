CREATE TEMP FUNCTION convert_cname_json(json_str STRING)
RETURNS ARRAY<STRUCT<hostname STRING, cname STRING>>
LANGUAGE js AS """
  const obj = JSON.parse(json_str);
  const result = [];
  for (const key in obj) {
    result.push({
      hostname: key,
      cname: obj[key]
    });
  }
  return result;
""";

SELECT
  NET.REG_DOMAIN(cnames.cname) AS cname,
  COUNT(DISTINCT NET.REG_DOMAIN(cnames.hostname)) AS request_domain_count,
  COUNT(DISTINCT page) AS page_count,
  ARRAY_AGG(DISTINCT cnames.hostname LIMIT 2) AS request_domain_examples,
FROM `httparchive.all.pages`,
UNNEST(convert_cname_json(JSON_QUERY(custom_metrics, '$.privacy.request_hostnames_with_cname'))) AS cnames
WHERE
  date = '2024-06-01' AND
  is_root_page = TRUE AND
  rank <= 10000
GROUP BY cname
ORDER BY request_domain_count DESC
LIMIT 100
