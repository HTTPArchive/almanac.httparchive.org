CREATE OR REPLACE TABLE `httparchive.almanac.wasm_stats`
PARTITION BY date
CLUSTER BY client AS
SELECT DATE('2021-09-01') AS date, * FROM (
  SELECT * EXCEPT (_TABLE_SUFFIX), _TABLE_SUFFIX AS client
  FROM (SELECT * EXCEPT (size) FROM `blink-httparchive-research.rreverser2.wasms`)
  JOIN `blink-httparchive-research.rreverser2.wasm_stats` USING (filename)
  JOIN `httparchive.summary_requests.2021_09_01_*` USING (url)
  JOIN (SELECT url AS page, pageid, _TABLE_SUFFIX FROM `httparchive.summary_pages.2021_09_01_*`) USING (_TABLE_SUFFIX, pageid)
)
