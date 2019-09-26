#standardSQL
# 04_09a: Client Hints
CREATE TEMP FUNCTION hasClientHintMeta(payload STRING)
RETURNS BOOLEAN LANGUAGE js AS '''
try {
  var $ = JSON.parse(payload);
  var almanac = JSON.parse($._almanac);
  return !!almanac['meta-nodes'].find(meta => meta['http-equiv'].toLowerCase() == 'accept-ch');
} catch (e) {
  return null;
}
''';

SELECT
  client,
  COUNTIF(accept_ch_header) AS accept_ch_header,
  COUNTIF(accept_ch_meta) AS accept_ch_meta,
  COUNTIF(accept_ch_header OR accept_ch_meta) AS either,
  COUNT(0) AS total,
  ROUND(COUNTIF(accept_ch_header) * 100 / COUNT(0), 2) AS pct_accept_ch_header,
  ROUND(COUNTIF(accept_ch_meta) * 100 / COUNT(0), 2) AS pct_accept_ch_meta,
  ROUND(COUNTIF(accept_ch_header OR accept_ch_meta) * 100 / COUNT(0), 2) AS pct_either
FROM (
  SELECT
    client,
    page,
    REGEXP_CONTAINS(LOWER(respOtherHeaders), 'accept-ch =') AS accept_ch_header
  FROM
    `httparchive.almanac.requests`
  WHERE
    firstHtml)
JOIN (
  SELECT
    _TABLE_SUFFIX AS client,
    url AS page,
    hasClientHintMeta(payload) AS accept_ch_meta
  FROM
    `httparchive.pages.2019_07_01_*`)
USING
  (client, page)
GROUP BY
  client