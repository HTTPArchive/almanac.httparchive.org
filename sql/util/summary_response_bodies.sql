SELECT
  date,
  client,
  page,
  url,
  body,
  truncated,
  NULL AS pageid,
  SAFE_CAST(requestId AS INT64) AS requestid,
  startedDateTime, time, method, urlShort, redirectUrl, firstReq, firstHtml, reqHttpVersion, reqHeadersSize, reqBodySize, reqCookieLen, reqOtherHeaders, status, respHttpVersion, respHeadersSize, respBodySize, respSize, respCookieLen,
  SAFE_CAST(expAge AS INT64) AS expAge,
  * EXCEPT (date, client, page, url, body, truncated, requestId, startedDateTime, time, method, urlShort, redirectUrl, firstReq, firstHtml, reqHttpVersion, reqHeadersSize, reqBodySize, reqCookieLen, reqOtherHeaders, status, respHttpVersion, respHeadersSize, respBodySize, respSize, respCookieLen, expAge, type, ext, format, payload),
  NULL AS crawlid,
  type,
  ext,
  format
FROM (
  SELECT
    *
  FROM
    `httparchive.almanac.requests`
  WHERE
    date = '2020-08-01')
JOIN
  (SELECT _TABLE_SUFFIX AS client, * FROM `httparchive.response_bodies.2020_08_01_*`)
USING
  (client, page, url, requestId)