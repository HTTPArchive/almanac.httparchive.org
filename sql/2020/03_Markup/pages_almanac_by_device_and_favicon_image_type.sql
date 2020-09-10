#standardSQL
# page almanac favicon image types grouped by device and type M217

CREATE TEMP FUNCTION AS_PERCENT (freq FLOAT64, total FLOAT64) RETURNS FLOAT64 AS (
  ROUND(SAFE_DIVIDE(freq, total), 4)
);

# returns all the data we need from _almanac
CREATE TEMPORARY FUNCTION get_almanac_info(almanac_string STRING)
RETURNS STRUCT<
  image_type_extension STRING
> LANGUAGE js AS '''
var result = {};
try {
    var almanac;
    if (true) { // LIVE = true
      almanac = JSON.parse(almanac_string); // LIVE
    }
    else {
      // TEST
      almanac = {
        "link-nodes": {
            "total": 36,
            "nodes": [{
                "tagName": "link",
                "rel": "icon",
                "type": "image/png",
                "href": "fgdhfgdhfdghgfdhfdghdfghfghdg/dfgdfgdfs/dfgfdsgdfgs/fdgfdg.png?hgfhfgdh"
            }]
        }
      };
      if (Math.floor(Math.random() * 3) == 0) {
        almanac["link-nodes"].nodes[0].href = "fgdhfgdhfdghgfdhfdghdfghfghdg/dfgdfgdfs/dfgfdsgdfgs/fdgfdg.jpg?hgfhfgdh";
      } else if (Math.floor(Math.random() * 3) == 0) {
        almanac["link-nodes"].nodes[0].href = "fgdhfgdhfdghgfdhfdghdfghfghdg/dfgdfgdfs/dfgfdsgdfgs/fdgfdg.svg";
      } else if (Math.floor(Math.random() * 3) == 0) {
        almanac["link-nodes"].nodes[0].href = "fgdhfgdhfdghgfdhfdghdfghfghdg/dfgdfgdfs/dfgfdsgdfgs/fdgfdg.gif";
      }
    }

    if (Array.isArray(almanac) || typeof almanac != 'object') return result;

    if (almanac["link-nodes"] && almanac["link-nodes"].nodes) {
      var faviconNode = almanac["link-nodes"].nodes.find(n => n.rel && n.rel.split(' ').find(r => r.trim().toLowerCase() == 'icon'));

      if (faviconNode) {
        if (faviconNode.href) {
          var temp = faviconNode.href;

          if (temp.includes('?')) {
            temp = temp.substring(0, temp.indexOf('?'));
          }

          if (temp.includes('.')) {
            temp = temp.substring(temp.lastIndexOf('.')+1);

            result.image_type_extension = temp;
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

} catch (e) {result.image_type_extension = "ERROR: "+e.message;}
return result;
''';

SELECT
  client,
  almanac_info.image_type_extension AS image_type_extension,

  COUNT(0) AS freq,

  AS_PERCENT(COUNT(0), SUM(COUNT(0)) OVER (PARTITION BY client)) AS pct

  FROM
    ( 
      SELECT 
        _TABLE_SUFFIX AS client,
        #get_almanac_info('') AS almanac_info  # TEST
        get_almanac_info(JSON_EXTRACT_SCALAR(payload, '$._almanac')) AS almanac_info # LIVE
      FROM
        #`httparchive.sample_data.pages_*` # TEST
        `httparchive.pages.2020_08_01_*` # LIVE
    )
GROUP BY
  client,
  image_type_extension
ORDER BY freq DESC
