#standardSQL
# page almanac favicon image types grouped by device and type

# returns all the data we need from _almanac
CREATE TEMPORARY FUNCTION getFaviconImage(almanac_string STRING)
RETURNS STRUCT<
  image_type_extension STRING
> LANGUAGE js AS '''
var result = {};
try {
    var almanac = JSON.parse(almanac_string);

    if (Array.isArray(almanac) || typeof almanac != 'object') return result;

    if (almanac["link-nodes"] && almanac["link-nodes"].nodes && almanac["link-nodes"].nodes.find) {
      var faviconNode = almanac["link-nodes"].nodes.find(n => n.rel && n.rel.split(' ').find(r => r.trim().toLowerCase() == 'icon'));

      if (faviconNode) {
        if (faviconNode.href) {
          var temp = faviconNode.href;

          if (temp.includes('?')) {
            temp = temp.substring(0, temp.indexOf('?'));
          }

          if (temp.includes('.')) {
            temp = temp.substring(temp.lastIndexOf('.')+1);

            result.image_type_extension = temp.toLowerCase().trim();
          }
          else {
            result.image_type_extension = "NO_EXTENSION";
          }

        } else {
          result.image_type_extension = "NO_HREF";
        }
      } else {
        result.image_type_extension = "NO_ICON";
      }
    }
    else {
      result.image_type_extension = "NO_DATA";
    }

} catch (e) {result.image_type_extension = "NO_DATA";}
return result;
''';

SELECT
  client,
  favicon.image_type_extension AS image_type_extension,
  COUNT(0) AS freq,
  SUM(COUNT(0)) OVER (PARTITION BY client) AS total,
  COUNT(0) / SUM(COUNT(0)) OVER (PARTITION BY client) AS pct
FROM (
  SELECT
    _TABLE_SUFFIX AS client,
    getFaviconImage(JSON_EXTRACT_SCALAR(payload, '$._almanac')) AS favicon
  FROM
    `httparchive.pages.2021_07_01_*`
)
GROUP BY
  client,
  image_type_extension
ORDER BY
  pct DESC,
  client,
  freq DESC
LIMIT 1000
