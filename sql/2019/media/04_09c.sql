#standardSQL
# 04_09c: Top Client Hints
SELECT
  client, ch, SUM(hits) hits
FROM
(
  SELECT
    client,
    REGEXP_REPLACE(concat(IFNULL(chHTML, ''), ',', IFNULL(chHeader, '')), r'^,|,$| ', '') acceptCH,
    COUNT(0) hits
  FROM
  (
    SELECT
      client,
      page,
      replace(regexp_extract(regexp_extract(body, r'(?is)<meta[^><]*Accept-CH\b[^><]*'), r'(?im).*content=[&quot;#32"\']*([^\'"><]*)'), "&#32;", '') chHTML,
      regexp_extract(regexp_extract(respOtherHeaders, r'(?is)Accept-CH = (.*)'), r'(?im)^([^=]*?)(?:, [a-z-]+ = .*)') chHeader
    FROM
      `httparchive.almanac.summary_response_bodies`
    WHERE
      date = '2019-07-01' AND
      firstHtml AND
      ( REGEXP_CONTAINS(body, r'(?im)<meta[^><]*Accept-CH\b') OR
        REGEXP_CONTAINS(respOtherHeaders, r'(?im)Accept-CH = ') )
  )
  GROUP BY
    client,
    chHTML,
    chHeader
)
cross join unnest(split(LOWER(acceptCH), ',')) AS ch
GROUP BY
  client,
  ch
HAVING
  ch <> ''
ORDER BY
  client DESC,
  hits DESC
