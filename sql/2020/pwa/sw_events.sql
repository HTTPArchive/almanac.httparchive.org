#standardSQL
# SW events - based on 2019/14_03.sql
SELECT
  client,
  event,
  COUNT(DISTINCT page) AS freq,
  total,
  COUNT(DISTINCT page) / total AS pct
FROM
  `httparchive.almanac.service_workers`
JOIN (SELECT client, COUNT(DISTINCT page) AS total FROM `httparchive.almanac.service_workers` WHERE date = '2020-08-01' GROUP BY client)
USING (client),
  UNNEST(ARRAY_CONCAT(
    REGEXP_EXTRACT_ALL(body, r'\.on(install|activate|fetch|push|notificationclick|notificationclose|sync|canmakepayment|paymentrequest|message|messageerror)\s*='),
    REGEXP_EXTRACT_ALL(body, r'addEventListener\(\s*[\'"](install|activate|fetch|push|notificationclick|notificationclose|sync|canmakepayment|paymentrequest|message|messageerror)[\'"]')
  )) AS event
WHERE
  date = '2020-08-01'
GROUP BY
  client,
  total,
  event
ORDER BY
  freq / total DESC
