CREATE TEMPORARY FUNCTION getFaviconImage(almanac_string STRING)
RETURNS STRING LANGUAGE js AS '''
var result = 'NO_DATA';
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

            result = temp.toLowerCase().trim();
          }
          else {
            result = "NO_EXTENSION";
          }

        } else {
          result = "NO_HREF";
        }
      } else {
        result = "NO_ICON";
      }
    }
    else {
      result = "NO_DATA";
    }

} catch {}
return result;
''';

WITH favicons AS (
  SELECT
    _TABLE_SUFFIX AS client,
    getFaviconImage(JSON_EXTRACT_SCALAR(payload, '$._almanac')) AS image_type_extension,
    COUNT(0) AS freq,
    SUM(COUNT(0)) OVER (PARTITION BY _TABLE_SUFFIX) AS total,
    COUNT(0) / SUM(COUNT(0)) OVER (PARTITION BY _TABLE_SUFFIX) AS pct
  FROM
    `httparchive.pages.2022_06_01_*`
  GROUP BY
    client,
    image_type_extension
)

SELECT
  *
FROM
  favicons
ORDER BY
  pct DESC
LIMIT
  1000
