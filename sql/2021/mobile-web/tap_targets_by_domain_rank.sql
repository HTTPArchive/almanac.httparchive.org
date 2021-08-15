#standardSQL
# % mobile sites with correctly sized tap targets by domain rank (note: the score is not binary)
SELECT
  rank,

  COUNTIF(tap_targets_score IS NOT NULL) AS total_applicable,
  COUNTIF(CAST(tap_targets_score AS NUMERIC) = 1) AS total_sufficient,
  COUNTIF(CAST(tap_targets_score AS NUMERIC) = 1) / COUNTIF(tap_targets_score IS NOT NULL) AS perc_in_applicable
FROM (
  SELECT
    url,
    JSON_EXTRACT_SCALAR(report, '$.audits.tap-targets.score') AS tap_targets_score
  FROM
    `httparchive.lighthouse.2021_07_01_mobile`
)
JOIN (
  SELECT
    url,
    rank,
  FROM
    `httparchive.summary_pages.2021_07_01_mobile`
) USING (url)
GROUP BY
  rank
