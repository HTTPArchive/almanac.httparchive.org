#standardSQL
# Correlations between various JS factors on UX (mobile only)
SELECT
  CORR(performance_score, bytesJs) AS js_bytes_on_performance_score,
  CORR(accessibility_score, bytesJs) AS js_bytes_on_accessibility_score,
  CORR(tbt, bytesJs) AS js_bytes_on_tbt,
  CORR(performance_score, third_party_scripts) AS third_party_scripts_on_performance_score,
  CORR(accessibility_score, third_party_scripts) AS third_party_scripts_on_accessibility_score,
  CORR(tbt, third_party_scripts) AS third_party_scripts_on_tbt,
  CORR(performance_score, num_async_scripts) AS num_async_scripts_on_performance_score,
  CORR(accessibility_score, num_async_scripts) AS num_async_scripts_on_accessibility_score,
  CORR(tbt, num_async_scripts) AS num_async_scripts_on_tbt
FROM (
  SELECT
    pageid,
    url AS page,
    bytesJs
  FROM
    `httparchive.summary_pages.2020_09_01_mobile`)
JOIN (
  SELECT
    url AS page,
    SAFE_CAST(JSON_EXTRACT_SCALAR(report, '$.categories.performance.score') AS FLOAT64) AS performance_score,
    SAFE_CAST(JSON_EXTRACT_SCALAR(report, '$.categories.accessibility.score') AS FLOAT64) AS accessibility_score,
    SAFE_CAST(JSON_EXTRACT_SCALAR(report, "$.audits['total-blocking-time'].numericValue") AS FLOAT64) AS tbt
  FROM
    `httparchive.lighthouse.2020_09_01_mobile`)
USING
  (page)
JOIN (
  SELECT
    pageid,
    SUM(respSize) AS third_party_scripts
  FROM
    `httparchive.summary_requests.2020_09_01_mobile`
  WHERE
    type = 'script' AND
    NET.HOST(url) IN (SELECT domain FROM `httparchive.almanac.third_parties` WHERE date = '2020-08-01' AND category != 'hosting')
  GROUP BY
    pageid)
USING
  (pageid)
JOIN (
  SELECT
    url AS page,
    SAFE_CAST(JSON_EXTRACT_SCALAR(payload, '$._num_scripts_async') AS INT64) AS num_async_scripts
  FROM
    `httparchive.pages.2020_09_01_mobile`)
USING
  (page)
