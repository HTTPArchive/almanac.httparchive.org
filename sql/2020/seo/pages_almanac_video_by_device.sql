#standardSQL
# page almanac metrics grouped by device for video tags

# helper to create percent fields
CREATE TEMP FUNCTION AS_PERCENT (freq FLOAT64, total FLOAT64) RETURNS FLOAT64 AS (
  ROUND(SAFE_DIVIDE(freq, total), 4)
);

# returns all the data we need from _almanac
CREATE TEMPORARY FUNCTION get_almanac_info(almanac_string STRING)
RETURNS STRUCT<
    videos_total INT64
> LANGUAGE js AS '''
var result = {
  videos_total: 0
};
try {
    var almanac = JSON.parse(almanac_string);

    if (Array.isArray(almanac) || typeof almanac != 'object') return result;

    if (almanac.videos && almanac.videos.total) {
      result.videos_total = almanac.videos.total;
    }
} catch (e) {}
return result;
''';

SELECT
  client,
  COUNT(0) AS total,

  # Pages with videos
  COUNTIF(almanac_info.videos_total > 0) AS has_videos,
  AS_PERCENT(COUNTIF(almanac_info.videos_total > 0), COUNT(0)) AS pct_has_videos

FROM
    (
      SELECT
        _TABLE_SUFFIX AS client,
        get_almanac_info(JSON_EXTRACT_SCALAR(payload, '$._almanac')) AS almanac_info
      FROM
        `httparchive.pages.2020_08_01_*`
    )
GROUP BY
  client
