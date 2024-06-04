#standardSQL
# 04_16: Pages self-serving video
SELECT
  client,
  COUNT(DISTINCT page) AS pages,
  total,
  ROUND(COUNT(DISTINCT page) * 100 / total, 2) AS pct
FROM
  `httparchive.almanac.requests`
JOIN (SELECT _TABLE_SUFFIX AS client, COUNT(0) AS total FROM `httparchive.summary_pages.2019_07_01_*` GROUP BY _TABLE_SUFFIX)
USING (client)
WHERE
  date = '2019-07-01' AND
  type = 'video' AND
  NET.REG_DOMAIN(url) NOT IN ('youtube.com', 'youtube-nocookie.com', 'googlevideo.com', 'fbcdn.net', 'vimeocdn.com')
GROUP BY
  client,
  total
