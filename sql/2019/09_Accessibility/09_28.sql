#standardSQL
# 09_28: Pages that auto refresh, e.g. http-equiv="refresh" attribute in the meta tag
SELECT
  client,
  COUNTIF(total_matches > 0) AS occurrences,
  total_pages,
  ROUND(COUNTIF(total_matches > 0) * 100 / total_pages, 2) AS occurrence_percentage
FROM (
  SELECT
    client,
    url,
    COUNT(regex_match) AS total_matches
  FROM
    `httparchive.almanac.summary_response_bodies`,
    UNNEST(REGEXP_EXTRACT_ALL(body, '(?i)<\\s*meta\\s[^>]*http-equiv=[\'"]?\\s*refresh\\s*[\'"]?')) AS regex_match
  WHERE firstHtml
  GROUP BY
    url,
    client
)
JOIN
  (SELECT _TABLE_SUFFIX AS client, COUNT(0) AS total_pages FROM `httparchive.summary_pages.2019_07_01_*` GROUP BY _TABLE_SUFFIX)
USING (client)
GROUP BY client, total_pages
ORDER BY occurrences DESC
