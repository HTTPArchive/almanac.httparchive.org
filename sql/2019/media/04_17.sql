#standardSQL
# 04_17: Video player size
SELECT
  percentile,
  client,
  player,
  SUM(COUNT(0)) OVER (PARTITION BY client, player) AS requests,
  ROUND(APPROX_QUANTILES(respSize, 1000)[OFFSET(percentile * 10)] / 1024, 2) AS kbytes
FROM (
  SELECT
    client,
    respSize,
    LOWER(REGEXP_EXTRACT(url, '(?i)(hls|video|shaka|jwplayer|brightcove-player-loader|flowplayer)[(?:\\.min)]?\\.js')) AS player
  FROM
    `httparchive.almanac.requests`
  WHERE
    date = '2019-07-01' AND
    type = 'script'
),
  UNNEST([10, 25, 50, 75, 90]) AS percentile
WHERE
  player IS NOT NULL
GROUP BY
  percentile,
  client,
  player
ORDER BY
  percentile,
  client,
  kbytes DESC
