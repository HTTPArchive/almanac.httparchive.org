#standardSQL
# extensions of loaded video URLs
# video_ext.sql

SELECT _TABLE_SUFFIX AS client, ext, COUNT(ext) AS cnt
FROM `httparchive.summary_requests.2022_06_01_*`
WHERE mimetype LIKE '%video%'
GROUP BY client, ext
ORDER BY cnt DESC
