#standardSQL
# LH5 vs LH6 score. WIP

# Performance Score from LH5 and LH6
SELECT lh6.url AS url,
  JSON_EXTRACT(lh6.report, '$.categories.performance.score') AS perf_score_lh6,
  JSON_EXTRACT(lh5.report, '$.categories.performance.score') AS perf_score_lh5,
  FROM `httparchive.sample_data.lighthouse_mobile_10k` lh6
  JOIN `httparchive.scratchspace.2020_03_01_lighthouse_mobile_10k` lh5 ON lh5.url=lh6.url