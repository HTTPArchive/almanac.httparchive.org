#standardSQL
# Videos per page 

# returns all the data we need from _almanac
CREATE TEMPORARY FUNCTION getVideosAlmanacInfo(almanac_string STRING)
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

WITH page_video_info AS (
  SELECT
    client AS client,
    percentile,
    page,
    CASE
      WHEN REGEXP_CONTAINS(page, '^https?://[^/]+/$') THEN 'homepage'
      ELSE 'secondary'
    END AS page_type,
    getVideosAlmanacInfo(JSON_EXTRACT_SCALAR(payload, '$._almanac')) AS video_almanac_info
  FROM
    `httparchive.all.pages` TABLESAMPLE SYSTEM (0.01 PERCENT),
    UNNEST([10, 25, 50, 75, 90]) AS percentile
  WHERE
    date = "2024-06-01"
)

SELECT
  percentile,
  client,
  page_type,
  COUNT(DISTINCT page) AS total,

  # videos per page
  APPROX_QUANTILES(video_almanac_info.videos_total, 1000)[OFFSET(percentile * 10)] AS videos_count

FROM
  page_video_info
WHERE
  video_almanac_info.videos_total > 0
GROUP BY
  percentile,
  client,
  page_type
ORDER BY
  percentile,
  client,
  page_type
