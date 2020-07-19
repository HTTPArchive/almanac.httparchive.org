#standardSQL
# LH5 vs LH6 score

SELECT url, JSON_EXTRACT(report, '$.categories.performance.score') AS performance_score FROM `httparchive.sample_data.lighthouse_mobile_10k` LIMIT 100