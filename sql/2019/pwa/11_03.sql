#standardSQL
# 11_03: SW events
SELECT
  client,
  event,
  COUNT(DISTINCT page) AS freq,
  total,
  ROUND(COUNT(DISTINCT page) * 100 / total, 2) AS pct
FROM
  `httparchive.almanac.service_workers`
JOIN (SELECT client, COUNT(DISTINCT page) AS total FROM `httparchive.almanac.service_workers` GROUP BY client)
USING (client),
  UNNEST(ARRAY_CONCAT(
    REGEXP_EXTRACT_ALL(body, r'\.on(install|activate|fetch|push|notificationclick|notificationclose|sync|canmakepayment|paymentrequest|message|messageerror)\s*='),
    REGEXP_EXTRACT_ALL(body, r'addEventListener\(\s*[\'"](install|activate|fetch|push|notificationclick|notificationclose|sync|canmakepayment|paymentrequest|message|messageerror)[\'"]')
  )) AS event
WHERE
  date = '2019-07-01'
GROUP BY
  client,
  total,
  event
ORDER BY
  freq / total DESC
