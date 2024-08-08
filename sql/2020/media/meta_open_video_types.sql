#standardSQL
# meta open graph video types

# returns all the data we need from _almanac
CREATE TEMPORARY FUNCTION get_meta_og_video_types(almanac_string STRING)
RETURNS STRUCT<
  video_types ARRAY<STRING>
> LANGUAGE js AS '''
var result = {};
try {
    var almanac = JSON.parse(almanac_string);

    if (Array.isArray(almanac) || typeof almanac != 'object') return result;

    for (var node of almanac['meta-nodes']['nodes']) {
      if (node['property'] === 'og:video') {
        if (result.video_types == null)
          result.video_types = [];
        var url = node['content'];
        // parse video extension from url
        // https://www.example.com/filename.ext?param=1234#anchor
        // first group is for file name, second for extension and
        // third one for the remaining of the url
        var rex = new RegExp('([^/]+)[.]([^/#?&]+)([#?][^/]*)?$');
        var ext = url.match(rex);
        result.video_types.push(ext[2].toLowerCase().trim());
      }
    }
} catch (e) {}
return result;
''';

SELECT
  client,
  video_type,
  COUNT(0) AS video_type_count,
  SAFE_DIVIDE(COUNT(0), SUM(COUNT(0)) OVER (PARTITION BY client)) AS video_type_pct
FROM (
  SELECT
    _TABLE_SUFFIX AS client,
    url,
    get_meta_og_video_types(JSON_EXTRACT_SCALAR(payload, '$._almanac')) AS almanac_info
  FROM
    `httparchive.pages.2020_08_01_*`
),
  UNNEST(almanac_info.video_types) AS video_type
GROUP BY
  client, video_type
HAVING
  video_type_count > 10
ORDER BY
  client,
  video_type_count DESC;
