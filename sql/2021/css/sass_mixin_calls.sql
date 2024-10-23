#standardSQL
CREATE TEMPORARY FUNCTION getMixinUsage(payload STRING) RETURNS
ARRAY<STRUCT<mixin STRING, freq INT64>> LANGUAGE js AS '''
try {
  var $ = JSON.parse(payload);
  var scss = JSON.parse($['_sass']);
  if (!scss.scss) {
    return [];
  }

  return Object.entries(scss.scss.stats.mixins).map(([mixin, {calls}]) => {
    return {mixin, freq: calls};
  });
} catch (e) {
  return [];
}
''';

SELECT
  *
FROM (
  SELECT
    client,
    mixin,
    SUM(freq) AS freq,
    SUM(SUM(freq)) OVER (PARTITION BY client) AS total,
    SUM(freq) / SUM(SUM(freq)) OVER (PARTITION BY client) AS pct
  FROM (
    SELECT
      _TABLE_SUFFIX AS client,
      mixin.mixin,
      mixin.freq
    FROM
      `httparchive.pages.2021_07_01_*`,
      UNNEST(getMixinUsage(payload)) AS mixin
  )
  GROUP BY
    client,
    mixin
)
WHERE
  freq >= 1000
ORDER BY
  pct DESC
