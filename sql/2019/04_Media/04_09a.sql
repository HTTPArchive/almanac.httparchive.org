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
  accept_ch_header,
  accept_ch_meta,
  total,
  ROUND(accept_ch_header * 100 / total, 2) AS pct_accept_ch_header,
  ROUND(accept_ch_meta * 100 / total, 2) AS pct_accept_ch_meta
FROM (
  SELECT
    client,
    COUNTIF(REGEXP_CONTAINS(LOWER(respOtherHeaders), 'accept-ch =')) AS accept_ch_header
  FROM
    `httparchive.almanac.requests`
  WHERE
    firstHtml
  GROUP BY
    client)
JOIN (
  SELECT
    _TABLE_SUFFIX AS client,
    COUNTIF(hasClientHintMeta(payload)) AS accept_ch_meta,
    COUNT(0) AS total
  FROM
    `httparchive.pages.2019_07_01_*`
  GROUP BY
    client)
USING
  (client)