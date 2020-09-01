#standardSQL
# page robots_txt metrics grouped by device and status code

# helper to create percent fields
CREATE TEMP FUNCTION AS_PERCENT (freq FLOAT64, total FLOAT64) RETURNS FLOAT64 AS (
  ROUND(SAFE_DIVIDE(freq, total), 4)
);

# returns all the data we need from _robots_txt
CREATE TEMPORARY FUNCTION get_robots_txt_info(robots_txt_string STRING)
RETURNS STRUCT<
  user_agents ARRAY<STRING>
> LANGUAGE js AS '''
var result = {};
try {
    //var robots_txt = JSON.parse(robots_txt_string); // LIVE

    // TEST
    var robots_txt = {
      "redirected": false,
      "status": 200,
      "size": 205,
      "comment_lines": 0,
      "allow_lines": 0,
      "disallow_lines": 5,
      "user_agents": [],
      "sitemaps": [
          "https://www.mozilla.org/sitemap.xml"
      ]
    }; 
    if (Math.floor(Math.random() * 20) == 0) {
      robots_txt.user_agents.push("LinkChecker");
    }
    if (Math.floor(Math.random() * 2) == 0) {
      robots_txt.user_agents.push("*");
      if (Math.floor(Math.random() * 2) == 0) { // sometimes two
        robots_txt.user_agents.push("*");
      }
    }

    if (Math.floor(Math.random() * 4) == 0) {
      robots_txt.user_agents.push("googlebot");
    }

    if (Array.isArray(robots_txt) || typeof robots_txt != 'object') return result;

    if (robots_txt.user_agents) {
      var uas = robots_txt.user_agents.map(ua => ua.toLowerCase());
      var uas =  uas.filter(function(item, pos) { return uas.indexOf(item) == pos;}); // remove duplicates
      result.user_agents = uas; 
    }

} catch (e) {}
return result;
''';

SELECT
  client,
  user_agent,
  total, 
  COUNT(*) AS count,
  AS_PERCENT(COUNT(*), total) AS pct
FROM
( 
  SELECT 
    _TABLE_SUFFIX AS client,
    total,
    get_robots_txt_info('') AS robots_txt_info # TEST
    #get_robots_txt_info(JSON_EXTRACT_SCALAR(payload, '$._robots_txt')) AS robots_txt_info # LIVE   
  FROM
    `httparchive.sample_data.pages_*` test # TEST   
  JOIN
  ( 
    # to get an accurate total of pages per device. also seems fast
    SELECT _TABLE_SUFFIX, COUNT(0) AS total 
    FROM `httparchive.sample_data.pages_*` # TEST
    GROUP BY _TABLE_SUFFIX
  ) 
  USING (_TABLE_SUFFIX)
),
UNNEST(robots_txt_info.user_agents) as user_agent
GROUP BY total, user_agent, client