#standardSQL
# Robots meta/header user agent directive usage

CREATE TEMPORARY FUNCTION parseRobotsMeta(robotsMetaJson STRING)
RETURNS ARRAY<STRUCT<
  bot STRING, report STRING,
  noindex INT64, `index` INT64, follow INT64, `none` INT64, nofollow INT64,
  noarchive INT64, nosnippet INT64, unavailable_after INT64,
  max_snippet INT64, max_image_preview INT64, max_video_preview INT64,
  notranslate INT64, noimageindex INT64, nocache INT64, indexifembedded INT64
>> LANGUAGE js AS '''
var results = [];
if (!robotsMetaJson) return results;

var robotsMetaParsed;
try { robotsMetaParsed = JSON.parse(robotsMetaJson); } catch (e) { return results; }

const reports = ['main_frame_robots_rendered', 'main_frame_robots_raw', 'main_frame_robots_headers', 'iframe_robots_raw', 'iframe_robots_headers'];
for (var i = 0; i < reports.length; i++) {
  var report = reports[i];
  var reportData = robotsMetaParsed && robotsMetaParsed[report];

  if (reportData && typeof reportData === 'object') {
    // Map ALL bots (remove the [0] that dropped everything but the first)
    Object.entries(reportData).forEach(function(entry){
      var bot = entry[0], botData = entry[1] || {};
      var row = { report: report, bot: bot };

      // normalize keys and coerce to 0/1
      Object.entries(botData).forEach(function(kv){
        var key = String(kv[0]).replace(/-/g, '_');
        var v = Number(kv[1]) || 0;
        row[key] = v > 0 ? 1 : 0;
      });

      results.push(row);
    });
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
    TO_JSON_STRING(custom_metrics.other.robots_meta) AS robots_meta_json
  FROM `httparchive.crawl.pages`
  WHERE date = '2025-07-01'
)

SELECT
  client,
  is_root_page,
  data.bot AS bot,
  data.report AS report,
  COUNT(0) AS count,
  COUNT(DISTINCT page) AS sites,
  SAFE_DIVIDE(SUM(data.noindex), COUNT(0)) AS noindex,
  SAFE_DIVIDE(SUM(data.`index`), COUNT(0)) AS `index`,
  SAFE_DIVIDE(SUM(data.follow), COUNT(0)) AS follow,
  SAFE_DIVIDE(SUM(data.`none`), COUNT(0)) AS `none`,
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
  count DESC;
