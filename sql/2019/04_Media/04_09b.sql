#standardSQL
# 04_09b: Top Accept-CH
SELECT
  client,
  chHTML,
  chHeader,
  count(0) hits
FROM
(
  SELECT
    client,
    page,
    replace(regexp_extract(regexp_extract(body, r'(?is)<meta[^><]*Accept-CH\b[^><]*'), r'(?im).*content=[&quot;#32"\']*([^\'"><]*)'), "#32;", '') chHTML,
    regexp_extract(regexp_extract(respOtherHeaders, r'(?is)Accept-CH = (.*)'), r'(?im)^([^=]*?)(?:, [a-z-]+ = .*)') chHeader
  FROM `httparchive.almanac.summary_response_bodies`
  WHERE firstHtml
    AND ( regexp_contains(body, r'(?is)<meta[^><]*Accept-CH\b')
    OR regexp_contains(respOtherHeaders, r'(?is)Accept-CH = ') )
)
GROUP BY
  client,
  chHTML,
  chHeader
ORDER BY
  client DESC, hits DESC