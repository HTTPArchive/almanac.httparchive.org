#standardSQL
# meta open graph image types

# returns all the data we need from _almanac
CREATE TEMPORARY FUNCTION get_almanac_info(almanac_string STRING)
RETURNS STRUCT<
  image_types ARRAY<STRING>
> LANGUAGE js AS '''
var result = {};
try {
    var almanac = JSON.parse(almanac_string);

    if (Array.isArray(almanac) || typeof almanac != 'object') return result;

    for (var node of almanac['meta-nodes']['nodes']) {
      if (node['property'] === 'og:image') {
        if (result.image_types == null)
        result.image_types = [];
        let url = node['content'];
        var rex = new RegExp('\\.([^/#?]+)[.]([^/#?]+)([#?][^/]*)?$');
        var ext = url.match(rex);
        result.image_types.push(ext[2].toLowerCase().trim());  
      }
    }
} catch (e) {}
return result;
''';

SELECT
  client,
  image_type,
  COUNT(0) AS image_type_count,
  SAFE_DIVIDE(COUNT(0), SUM(COUNT(0)) OVER (PARTITION BY client)) AS image_type_pct
FROM (
  SELECT
    _TABLE_SUFFIX AS client,
    url,
    get_almanac_info(JSON_EXTRACT_SCALAR(payload, '$._almanac')) AS almanac_info
  FROM
    `httparchive.pages.2020_08_01_*`),
  UNNEST(almanac_info.image_types) AS image_type
GROUP BY
  client, image_type
HAVING
  image_type_count > 100
ORDER BY
  client,
  image_type_count DESC;
