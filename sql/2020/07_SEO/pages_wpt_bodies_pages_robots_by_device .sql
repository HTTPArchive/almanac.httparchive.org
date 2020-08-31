#standardSQL
# page robots metrics grouped by device

# helper to create percent fields
CREATE TEMP FUNCTION AS_PERCENT (freq FLOAT64, total FLOAT64) RETURNS FLOAT64 AS (
  ROUND(SAFE_DIVIDE(freq, total), 4)
);

# returns all the data we need from _robots
CREATE TEMPORARY FUNCTION get_robots_info(robots_string STRING)
RETURNS STRUCT<

  ##Antoine
  has_robots_meta_tag BOOL, 
  has_x_robots BOOL, 

  ######

  # Not sure about how to handle dictionnaries in BQ. 
  # @Tony: any idea 

  ######

  meta_robots_rendered STRING, 
  meta_robots_raw STRING

  # add more properties here...


> LANGUAGE js AS '''
var result = {};
try {
    //var robots = JSON.parse(robots_string); // LIVE

    // TEST
    //Fill test data 

    var robots = {}; 

    if (Array.isArray(robots) || typeof robots != 'object') return result;

    if (robots.has_robots_meta_tag) {
        result.has_robots_meta_tag = robots.has_robots_meta_tag;
    }

    if (robots.has_x_robots_tag) {
        result.has_x_robots_tag = robots.has_x_robots_tag;
    }

    if (robots.raw) {
        result.meta_robots_raw = robots.raw;
    }

    if (robots.rendered) {
        result.meta_robots_rendered = robots.rendered;
    }




    // add more code to set result properties here...

} catch (e) {}
return result;
''';

SELECT
  client,
  COUNT(0) AS total,

  ##Antoine

  # Pages with meta robots 
  #COUNTIF(robots_info.has_robots_meta_tag) as has_robots_meta_tag,
  AS_PERCENT(COUNTIF(robots_info.has_robots_meta_tag), COUNT(0)) AS pct_has_robots_meta_tag,

  # Pages with x robots  
  #COUNTIF(robots_info.has_x_robots) as has_x_robots,
  AS_PERCENT(COUNTIF(robots_info.has_x_robots), COUNT(0)) AS pct_has_x_robots,

  #########

  ####MISSING THE LAST METRIC






  FROM
    ( 
      SELECT 
        _TABLE_SUFFIX AS client,
        get_robots_info('') AS robots_info # TEST
        #get_robots_info(JSON_EXTRACT_SCALAR(payload, '$._robots')) AS robots_info # LIVE      
      FROM
        `httparchive.sample_data.pages_*` # TEST
    )
GROUP BY
  client