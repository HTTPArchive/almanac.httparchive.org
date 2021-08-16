#standardSQL
# usage meta open graph

# returns all the data we need from _almanac
CREATE TEMPORARY FUNCTION get_meta_og_info(almanac_string STRING)
RETURNS STRUCT<
  meta_og_image BOOLEAN,
  meta_og_video BOOLEAN
> LANGUAGE js AS '''
var result = {};
try {
    var almanac = JSON.parse(almanac_string);

    if (Array.isArray(almanac) || typeof almanac != 'object') return result;

    result.meta_og_image = false;
    result.meta_og_video = false;
    for (var node of almanac['meta-nodes']['nodes']) {
      if (node['property'] === 'og:image')
        result.meta_og_image = true;
      else if (node['property'] === 'og:video')
        result.meta_og_video = true;
    }
} catch (e) {}
return result;
''';

SELECT
  client,
  COUNTIF(almanac_info.meta_og_image) / COUNT(0) AS meta_og_image_pct,
  COUNTIF(almanac_info.meta_og_video) / COUNT(0) AS meta_og_video_pct,
  COUNTIF(almanac_info.meta_og_image AND almanac_info.meta_og_video) / COUNT(0) AS meta_og_image_video_pct
FROM (
  SELECT
    _TABLE_SUFFIX AS client,
    url,
    get_meta_og_info(JSON_EXTRACT_SCALAR(payload, '$._almanac')) AS almanac_info
  FROM
    `httparchive.pages.2020_08_01_*`)
GROUP BY
  client
ORDER BY
  client;
