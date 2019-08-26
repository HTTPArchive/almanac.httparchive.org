#15_06 - Text Based Compression Byte Savings
SELECT 
       ROUND(CAST(JSON_EXTRACT_SCALAR(report, "$.audits.uses-text-compression.details.overallSavingsBytes")as INT64)/1024/1024) byteSavings,
       count(*) Sites
       
FROM `httparchive.lighthouse.2019_07_01_mobile`
where JSON_EXTRACT_SCALAR(report, "$.audits.uses-text-compression.score") != "1"
GROUP BY byteSavings
ORDER BY byteSavings ASC
