#standardSQL
# Section: Content Inclusion - Subresource Integriy
# Question: How many scripts on a page have the integrity attribute? (percentage)
CREATE TEMP FUNCTION getNumScriptElements(sris ARRAY<STRING>) AS (
  (SELECT COUNT(0) FROM UNNEST(sris) AS sri WHERE JSON_EXTRACT_SCALAR(sri, '$.tagname') = 'script')
);

SELECT
  client,
  percentile,
  APPROX_QUANTILES(getNumScriptElements(sris) / num_scripts, 1000 IGNORE NULLS)[OFFSET(percentile * 10)] AS integrity_pct
FROM (
  SELECT
    client,
    JSON_EXTRACT_ARRAY(JSON_EXTRACT_SCALAR(payload, '$._security'), '$.sri-integrity') AS sris,
    SAFE_CAST(JSON_EXTRACT_SCALAR(JSON_EXTRACT_SCALAR(payload, '$._element_count'), '$.script') AS INT64) AS num_scripts
  FROM
    `httparchive.all.pages`
  WHERE
    date = '2024-06-01' AND
    is_root_page
  ),
  UNNEST([10, 25, 50, 75, 90]) AS percentile
WHERE
  getNumScriptElements(sris) > 0
GROUP BY
  client,
  percentile
ORDER BY
  client,
  percentile
