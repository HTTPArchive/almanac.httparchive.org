#standardSQL
# Robots meta/header user agent directive usage

CREATE TEMPORARY FUNCTION parseRobotsMeta(robotsMetaJson STRING)
RETURNS ARRAY<STRUCT<bot STRING, report STRING, noindex INT64, index INT64, follow INT64, none INT64, nofollow INT64, noarchive INT64, nosnippet INT64, unavailable_after INT64, max_snippet INT64, max_image_preview INT64, max_video_preview INT64, notranslate INT64, noimageindex INT64, nocache INT64, indexifembedded INT64>> LANGUAGE js AS '''

var results = [];

if (typeof robotsMetaJson === 'string') {
    var robotsMetaParsed = JSON.parse(robotsMetaJson);
    const reports = ['main_frame_robots_rendered', 'main_frame_robots_raw', 'main_frame_robots_headers', 'iframe_robots_raw', 'iframe_robots_headers']
    for (report of reports) {
        var reportData = robotsMetaParsed[report];
        var result = typeof reportData === 'object' ? Object.entries(reportData).map(([bot,botData])=>{
            return Object.assign({
                'report': report,
                'bot': bot
            }, Object.fromEntries(Object.entries(botData).map(([k,v])=>[k.replaceAll('-', '_'), v / Math.max(v, 1)])))
        }
        )[0] : null;

        if (result)
            results.push(result);

    }
}
return results;
''';
WITH Robots_Data AS (
  SELECT
    client,
    page,
    CASE
      WHEN is_root_page = FALSE THEN 'Secondarypage'
      WHEN is_root_page = TRUE THEN 'Homepage'
      ELSE 'No Assigned Page'
    END AS is_root_page,
    JSON_EXTRACT(payload, '$._robots_meta') AS robots_meta_json
  FROM
    `httparchive.all.pages`
  WHERE
    date = '2024-06-01'
)

SELECT
  client,
  is_root_page,
  data.bot AS bot,
  data.report AS report,
  COUNT(0) AS count,
  COUNT(DISTINCT page) AS sites,
  SAFE_DIVIDE(SUM(data.noindex), COUNT(0)) AS noindex,
  SAFE_DIVIDE(SUM(data.index), COUNT(0)) AS index,
  SAFE_DIVIDE(SUM(data.follow), COUNT(0)) AS follow,
  SAFE_DIVIDE(SUM(data.none), COUNT(0)) AS none,
  SAFE_DIVIDE(SUM(data.nofollow), COUNT(0)) AS nofollow,
  SAFE_DIVIDE(SUM(data.noarchive), COUNT(0)) AS noarchive,
  SAFE_DIVIDE(SUM(data.nosnippet), COUNT(0)) AS nosnippet,
  SAFE_DIVIDE(SUM(data.unavailable_after), COUNT(0)) AS unavailable_after,
  SAFE_DIVIDE(SUM(data.max_snippet), COUNT(0)) AS max_snippet,
  SAFE_DIVIDE(SUM(data.max_image_preview), COUNT(0)) AS max_image_preview,
  SAFE_DIVIDE(SUM(data.max_video_preview), COUNT(0)) AS max_video_preview,
  SAFE_DIVIDE(SUM(data.notranslate), COUNT(0)) AS notranslate,
  SAFE_DIVIDE(SUM(data.noimageindex), COUNT(0)) AS noimageindex,
  SAFE_DIVIDE(SUM(data.nocache), COUNT(0)) AS nocache,
  SAFE_DIVIDE(SUM(data.indexifembedded), COUNT(0)) AS indexifembedded
FROM
  Robots_Data,
  UNNEST(parseRobotsMeta(robots_meta_json)) AS data

GROUP BY
  client,
  is_root_page,
  bot,
  report
HAVING
  count >= 20

ORDER BY
  count DESC
