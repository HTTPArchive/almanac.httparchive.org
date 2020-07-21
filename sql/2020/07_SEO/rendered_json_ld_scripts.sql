#standardSQL
# number of json-ld scripts per page
# maybe should be a percentile

  SELECT
    client,
    COUNT(0) AS total,
    CAST(JSON_EXTRACT_SCALAR(almanac, "$['structured-data'].jsonLdScriptCount") AS INT64) AS jsonld_scripts_count
  FROM
  ( 
    SELECT 
    _TABLE_SUFFIX AS client,
    url,
    JSON_EXTRACT_SCALAR(payload, '$._almanac') AS almanac
    FROM
    `httparchive.almanac.pages_*`
  )
GROUP BY client, jsonld_scripts_count
ORDER BY jsonld_scripts_count DESC;