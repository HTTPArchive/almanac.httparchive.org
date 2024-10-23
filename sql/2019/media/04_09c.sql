#standardSQL
# 04_09c: Top Client Hints
SELECT
  client, ch, SUM(hits) AS hits
FROM (
  SELECT
    client,
    REGEXP_REPLACE(concat(IFNULL(chHTML, ''), ',', IFNULL(chHeader, '')), r'^,|,$| ', '') AS acceptCH,
    COUNT(0) AS hits
  FROM (
    SELECT
      client,
      page,
      replace(regexp_extract(regexp_extract(body, r'(?is)<meta[^><]*Accept-CH\b[^><]*'), r'(?im).*content=[&quot;#32"\']*([^\'"><]*)'), '&#32;', '') AS chHTML,
      regexp_extract(regexp_extract(respOtherHeaders, r'(?is)Accept-CH = (.*)'), r'(?im)^([^=]*?)(?:, [a-z-]+ = .*)') AS chHeader
    FROM
      `httparchive.almanac.summary_response_bodies`
    WHERE
      date = '2019-07-01' AND
      firstHtml AND (
        REGEXP_CONTAINS(body, r'(?im)<meta[^><]*Accept-CH\b') OR
        REGEXP_CONTAINS(respOtherHeaders, r'(?im)Accept-CH = ')
      )
  )
  GROUP BY
    client,
    chHTML,
    chHeader
)
CROSS JOIN UNNEST(SPLIT(LOWER(acceptCH), ',')) AS ch
GROUP BY
  client,
  ch
HAVING
  ch != ''
ORDER BY
  client DESC,
  hits DESC
