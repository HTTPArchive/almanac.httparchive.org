#standardSQL
# Section: Content Inclusion - Subresource Integriy
# Question: How many scripts on a page have the integrity attribute? (percentage)
CREATE TEMP FUNCTION getNumScriptElements(sris ARRAY<JSON>) AS (
  (SELECT COUNT(0) FROM UNNEST(sris) AS sri WHERE JSON_EXTRACT_SCALAR(sri, '$.tagname') = 'script')
);

SELECT
  client,
  percentile,
  APPROX_QUANTILES(getNumScriptElements(sris) / num_scripts, 1000 IGNORE NULLS)[OFFSET(percentile * 10)] AS integrity_pct
FROM (
  SELECT
    client,
    JSON_EXTRACT_ARRAY(custom_metrics.security, '$.sri-integrity') AS sris,
    SAFE_CAST(custom_metrics.element_count.script AS INT64) AS num_scripts
  FROM
    `httparchive.crawl.pages`
  WHERE
    date = '2025-07-01' AND
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
