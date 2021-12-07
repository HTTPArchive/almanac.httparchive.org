#standardSQL
# % mobile sites with correctly sized tap targets (note: the score is not binary)
SELECT
  COUNTIF(tap_targets_score IS NOT NULL) AS total_applicable,
  COUNTIF(CAST(tap_targets_score AS NUMERIC) = 1) AS total_sufficient,
  COUNTIF(CAST(tap_targets_score AS NUMERIC) = 1) / COUNTIF(tap_targets_score IS NOT NULL) AS perc_in_applicable
FROM (
  SELECT
    JSON_EXTRACT_SCALAR(report, '$.audits.tap-targets.score') AS tap_targets_score
  FROM
    `httparchive.lighthouse.2020_08_01_mobile`
)
