#standardSQL
# Temporary function to extract favicon image extensions from the JSON payload
CREATE TEMPORARY FUNCTION GETFAVICONIMAGE(payload STRING)
RETURNS STRING LANGUAGE js AS '''
var result = 'NO_DATA';
try {
    var almanac = JSON.parse(payload);

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

} catch (e) {}
return result;
''';

# Main query to analyze favicon image extensions with sampling
WITH favicons AS (
  SELECT
    client,
    GETFAVICONIMAGE(
      JSON_EXTRACT_SCALAR(payload, '$._almanac')
    ) AS image_type_extension,
    COUNT(0) AS freq,
    SUM(COUNT(0)) OVER (PARTITION BY client) AS total,
    COUNT(0) / SUM(COUNT(0)) OVER (PARTITION BY client) AS percentage_of_total
  FROM
    `httparchive.crawl.pages`
  WHERE
    date = '2025-06-01'
  GROUP BY
    client,
    image_type_extension
)

SELECT
  *,
  percentage_of_total AS pct
FROM
  favicons
ORDER BY
  pct DESC
