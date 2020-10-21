CREATE TEMP FUNCTION has_iab_banner(payload STRING)
RETURNS BOOLEAN LANGUAGE js AS '''
  try {
    var $ = JSON.parse(payload);
    return ($._privacy).includes('"iab_tcf":1');
  } catch (e) {
    return false;
  }
''';

SELECT 
  _TABLE_SUFFIX AS client,
  COUNTIF(has_iab_banner(payload)) AS num_pages
FROM `httparchive.pages.2020_08_01_*`  
GROUP BY client
  
