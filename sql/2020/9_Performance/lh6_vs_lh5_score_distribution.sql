#standardSQL
# LH5 vs LH6 score. WIP

# Performance Score
SELECT url, JSON_EXTRACT(report, '$.categories.performance.score') AS performance_score FROM `httparchive.sample_data.lighthouse_mobile_10k` LIMIT 100

# Intersected URLs for LH5 and LH6
SELECT lh6.url AS lh6_url, lh5.url AS lh5_url FROM `httparchive.lighthouse.2020_06_01_mobile` lh6 JOIN `httparchive.lighthouse.2020_03_01_mobile` lh5 ON lh5.url=lh6.url