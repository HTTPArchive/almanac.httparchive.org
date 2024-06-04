SELECT -- noqa: disable=L044
  date,
  client,
  page,
  url,
  body,
  truncated,
  NULL AS pageid,
  requestId AS requestid,
  startedDateTime, time, method, urlShort, redirectUrl, firstReq, firstHtml, reqHttpVersion, reqHeadersSize, reqBodySize, reqCookieLen, reqOtherHeaders, status, respHttpVersion, respHeadersSize, respBodySize, respSize, respCookieLen,
  expAge AS expAge,
  * EXCEPT (date, client, page, url, body, truncated, requestId, startedDateTime, time, method, urlShort, redirectUrl, firstReq, firstHtml, reqHttpVersion, reqHeadersSize, reqBodySize, reqCookieLen, reqOtherHeaders, status, respHttpVersion, respHeadersSize, respBodySize, respSize, respCookieLen, expAge, type, ext, format, payload),
  NULL AS crawlid,
  type,
  ext,
  format,
  payload
FROM (
  SELECT
    *
  FROM
    `httparchive.almanac.requests`
  WHERE
    date = '2022-06-01'
)
JOIN (SELECT _TABLE_SUFFIX AS client, * FROM `httparchive.response_bodies.2022_06_01_*`)
USING (client, page, url)
