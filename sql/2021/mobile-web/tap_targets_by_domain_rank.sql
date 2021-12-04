#standardSQL
# % mobile pages with correctly sized tap targets by domain rank (note: the score is not binary)
SELECT
  rank_grouping,

  COUNTIF(tap_targets_score IS NOT NULL) AS total_applicable,
  COUNTIF(CAST(tap_targets_score AS NUMERIC) = 1) AS total_sufficient,
  COUNTIF(CAST(tap_targets_score AS NUMERIC) = 1) / COUNTIF(tap_targets_score IS NOT NULL) AS pct_in_applicable
FROM (
  SELECT
    url,
    JSON_EXTRACT_SCALAR(report, '$.audits.tap-targets.score') AS tap_targets_score
  FROM
    `httparchive.lighthouse.2021_07_01_mobile`
)
LEFT JOIN (
  SELECT
    url,
    rank_grouping
  FROM
    `httparchive.summary_pages.2021_07_01_mobile`,
    UNNEST([1000, 10000, 100000, 1000000, 10000000]) AS rank_grouping
  WHERE
    rank <= rank_grouping
) USING (url)
GROUP BY
  rank_grouping
