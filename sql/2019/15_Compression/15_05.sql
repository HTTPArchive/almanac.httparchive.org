#15.05 - Distribution of Text Based Compression Lighthouse Scores
SELECT JSON_EXTRACT_SCALAR(report, "$.audits.uses-text-compression.score") TextCompressionScore,
       count(*)
FROM `httparchive.lighthouse.2019_07_01_mobile` 
where JSON_EXTRACT_SCALAR(report, "$.audits.uses-text-compression.score") != "1"
GROUP BY TextCompressionScore
ORDER BY TextCompressionScore ASC
