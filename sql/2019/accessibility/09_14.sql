#standardSQL
# 09_14: % pages using aria-keyshortcuts, accesskey attrs
SELECT
  client,
  COUNTIF(aria_keyshortcuts) AS freq_aria_keyshortcuts,
  COUNTIF(accesskey) AS freq_accesskey,
  total,
  ROUND(COUNTIF(aria_keyshortcuts) * 100 / total, 2) AS pct_aria_keyshortcuts,
  ROUND(COUNTIF(accesskey) * 100 / total, 2) AS pct_accesskey
FROM (
  SELECT
    client,
    REGEXP_CONTAINS(body, '(?i)<[^>]+aria-keyshortcuts=') AS aria_keyshortcuts,
    REGEXP_CONTAINS(body, '(?i)<[^>]+accesskey=') AS accesskey
  FROM
    `httparchive.almanac.summary_response_bodies`
  WHERE
    date = '2019-07-01' AND
    firstHtml
)
JOIN (SELECT _TABLE_SUFFIX AS client, COUNT(0) AS total FROM `httparchive.pages.2019_07_01_*` GROUP BY _TABLE_SUFFIX)
USING (client)
GROUP BY
  client,
  total
