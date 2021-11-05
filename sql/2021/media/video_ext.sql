SELECT _TABLE_SUFFIX AS client, ext, COUNT(ext) AS cnt
FROM `httparchive.summary_requests.2021_07_01_*`
WHERE mimetype LIKE "%video%"
GROUP BY client, ext
ORDER BY cnt DESC
