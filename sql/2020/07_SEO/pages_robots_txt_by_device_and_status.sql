#standardSQL
# page robots_txt metrics grouped by device and status code

# helper to create percent fields
CREATE TEMP FUNCTION AS_PERCENT (freq FLOAT64, total FLOAT64) RETURNS FLOAT64 AS (
  ROUND(SAFE_DIVIDE(freq, total), 4)
);

# returns all the data we need from _robots_txt
CREATE TEMPORARY FUNCTION get_robots_txt_info(robots_txt_string STRING)
RETURNS STRUCT<
  status_code STRING
> LANGUAGE js AS '''
var result = {};
try {
    var robots_txt;

    if (true) { // LIVE = true
      robots_txt = JSON.parse(robots_txt_string); // LIVE
    }
    else 
    {
      // TEST
      robots_txt = {
        "redirected": false,
        "status": 200,
        "size": 205,
        "comment_lines": 0,
        "allow_lines": 0,
        "disallow_lines": 5,
        "user_agents": [
            "LinkChecker",
            "*"
        ],
        "sitemaps": [
            "https://www.mozilla.org/sitemap.xml"
        ]
      }; 

      if (Math.floor(Math.random() * 10) == 0) {
        robots_txt.status = 500;
      } else if (Math.floor(Math.random() * 10) == 0) {
        robots_txt.status = 301;
      } else if (Math.floor(Math.random() * 3) == 0) {
        robots_txt.status = 404;
      }
    }

    if (Array.isArray(robots_txt) || typeof robots_txt != 'object') return result;

    if (robots_txt.status) {
       result.status_code = ''+robots_txt.status;
    }

} catch (e) {}
return result;
''';

SELECT
  client,
  robots_txt_info.status_code as status_code,

  COUNT(0) AS total,

  AS_PERCENT(COUNT(0), SUM(COUNT(0)) OVER (PARTITION BY client)) AS pct

  FROM
    ( 
      SELECT 
        _TABLE_SUFFIX AS client,
        #get_robots_txt_info('') AS robots_txt_info # TEST
        get_robots_txt_info(JSON_EXTRACT_SCALAR(payload, '$._robots_txt')) AS robots_txt_info # LIVE      
      FROM
        #`httparchive.sample_data.pages_*` # TEST
        `httparchive.pages.2020_08_01_*` # LIVE
    )
GROUP BY
  client,
  status_code