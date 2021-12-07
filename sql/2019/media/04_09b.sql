#standardSQL
# 04_09b: Top Accept-CH
SELECT
  client,
  chHTML,
  chHeader,
  COUNT(0) AS hits
FROM
  (
    SELECT
      client,
      page,
      replace(regexp_extract(regexp_extract(body, r'(?is)<meta[^><]*Accept-CH\b[^><]*'), r'(?im).*content=[&quot;#32"\']*([^\'"><]*)'), "#32;", '') AS chHTML,
      regexp_extract(regexp_extract(respOtherHeaders, r'(?is)Accept-CH = (.*)'), r'(?im)^([^=]*?)(?:, [a-z-]+ = .*)') AS chHeader
    FROM `httparchive.almanac.summary_response_bodies`
    WHERE
      date = '2019-07-01' AND
      firstHtml AND
      ( REGEXP_CONTAINS(body, r'(?is)<meta[^><]*Accept-CH\b') OR
        REGEXP_CONTAINS(respOtherHeaders, r'(?is)Accept-CH = ') )
  )
GROUP BY
  client,
  chHTML,
  chHeader
ORDER BY
  client DESC, hits DESC
